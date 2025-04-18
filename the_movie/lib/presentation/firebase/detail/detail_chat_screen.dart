import 'package:flutter/material.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/presentation/firebase/widgets/appbar.dart';
import 'package:the_movie/data/models/chat/detail_chat.dart';

import '../../../data/repositories/chat/chat_repository.dart';
import '../widgets/message_bubble.dart';

class DetailChatScreen extends StatefulWidget {
  const DetailChatScreen({super.key, required this.chatRoomId});

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
    try {
      ChatRepositoryImpl.instance
          .deleteDetailMessage(widget.chatRoomId, _messageController.text);
    } catch (e) {
      debugPrint('Error deleting message: $e');
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppbarWidget(
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
                      return Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: MessageBubble(
                          message: chat.message ?? '',
                          isMe: isMe,
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
