import 'package:flutter/material.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/presentation/firebase/widgets/appbar.dart';
import 'package:the_movie/data/models/chat/detail_chat.dart';

import '../../../data/repositories/chat/chat_repository.dart';
import '../widgets/custom_alert_dialog.dart';
import '../widgets/message_bubble.dart';

class DetailChatScreen extends StatefulWidget {
  const DetailChatScreen(
      {super.key, required this.chatRoomId, required this.name});

  final String name;
  final String chatRoomId;

  @override
  State<DetailChatScreen> createState() => _DetailChatState();
}

class _DetailChatState extends State<DetailChatScreen> {
  late ScrollController _scrollController;
  late TextEditingController _messageController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _messageController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageController.dispose();
    ChatRepositoryImpl.instance.updateLastMessage(widget.chatRoomId, '', false);
    super.dispose();
  }

  void _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    try {
      await ChatRepositoryImpl.instance
          .addDetailMessage(widget.chatRoomId, message);
      await ChatRepositoryImpl.instance
          .updateLastMessage(widget.chatRoomId, message, true);

      _messageController.clear();
    } catch (e, stack) {
      debugPrint('Send message error: $e');
      debugPrintStack(stackTrace: stack);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Gửi tin nhắn thất bại. Vui lòng thử lại.')),
      );
    }
  }

  void _onEditMessage(DetailChat chat) async {
    final newMessage = await showDialog<String>(
      context: context,
      builder: (context) => CustomAlertDialog(
        title: 'Sửa tin nhắn',
        content: chat.message ?? '',
        isInput: true,
        onConfirm: (value) => Navigator.pop(context, value),
        cancelText: 'Hủy',
        confirmText: 'Lưu',
      ),
    );

    if (newMessage != null && newMessage.isNotEmpty) {
      await ChatRepositoryImpl.instance.editDetailMessage(
        widget.chatRoomId,
        chat.messageId ?? '',
        newMessage,
      );
    }
  }

  void _onDeleteMessage(DetailChat chat) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => CustomAlertDialog(
        title: 'Xoá tin nhắn',
        content: 'Bạn có chắc chắn muốn xoá tin nhắn này không?',
        onConfirm: (_) => Navigator.pop(context, true),
        cancelText: 'Không',
        confirmText: 'Xoá',
      ),
    );

    if (confirm == true) {
      await ChatRepositoryImpl.instance.deleteDetailMessage(
        widget.chatRoomId,
        chat.messageId ?? '',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppbarWidget(
        name: widget.name,
        scrollController: _scrollController,
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<DetailChat>>(
                stream: ChatRepositoryImpl.instance
                    .getListDetailChat(widget.chatRoomId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final chats = snapshot.data ?? [];
                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(12),
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      final chat = chats[index];
                      final isMe =
                          chat.idSend == ChatRepositoryImpl.instance.user?.uid;
                      return Padding(
                        padding: EdgeInsets.all(PaddingSizes.p8),
                        child: Align(
                          alignment: isMe
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: MessageBubble(
                            message: chat.message ?? '',
                            isMe: isMe,
                            onEdit: () => _onEditMessage(chat),
                            onDelete: () => _onDeleteMessage(chat),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: PaddingSizes.p16, vertical: PaddingSizes.p8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: "Nhập tin nhắn...",
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(RadiusSizes.r32),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: PaddingSizes.p16,
                              vertical: PaddingSizes.p8),
                        ),
                      ),
                    ),
                    GapsManager.w10,
                    IconButton(
                      onPressed: _sendMessage,
                      icon: const Icon(Icons.send),
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
