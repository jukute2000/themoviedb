import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/presentation/firebase/widgets/appbar.dart';
import 'package:the_movie/data/models/chat/detail_chat.dart';

import '../../../core/configs/assets/app_strings.dart';
import '../../../data/repositories/chat/chat_repository.dart';
import '../widgets/custom_alert_dialog.dart';
import '../widgets/date_header.dart';
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
    ChatRepositoryImpl.instance
        .updateLastMessage(widget.chatRoomId, '', false, '');
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    try {
      await ChatRepositoryImpl.instance
          .addDetailMessage(widget.chatRoomId, message);
      _messageController.clear();
      Future.delayed(const Duration(milliseconds: 300), () {
        _scrollToBottom();
      });
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
        title: AppStrings.editMessage.tr(),
        content: chat.message ?? '',
        isInput: true,
        onConfirm: (value) => Navigator.pop(context, value),
        cancelText: AppStrings.cancel.tr(),
        confirmText: AppStrings.save.tr(),
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
        title: AppStrings.deleteMessage.tr(),
        content: AppStrings.deleteMessageTitle.tr(),
        onConfirm: (_) => Navigator.pop(context, true),
        cancelText: AppStrings.cancel.tr(),
        confirmText: AppStrings.confirm.tr(),
      ),
    );

    if (confirm == true) {
      await ChatRepositoryImpl.instance.deleteDetailMessage(
        widget.chatRoomId,
        chat.messageId ?? '',
      );
    }
  }

  bool isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  String formatDateHeader(DateTime date) {
    final now = DateTime.now();

    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Hôm nay';
    } else if (date.year == now.subtract(const Duration(days: 1)).year &&
        date.month == now.subtract(const Duration(days: 1)).month &&
        date.day == now.subtract(const Duration(days: 1)).day) {
      return 'Hôm qua';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppbarWidget(
        name: widget.name,
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

                  if (chats.isNotEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollToBottom();
                    });
                  }
                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(12),
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      final chat = chats[index];
                      final isMe =
                          chat.idSend == ChatRepositoryImpl.instance.user?.uid;
                      // Lấy ngày gửi
                      final chatDate = DateTime.parse(chat.time ?? "");
                      // So với ngày tin nhắn trước
                      bool showDateHeader = false;
                      if (index == 0) {
                        showDateHeader = true;
                      } else {
                        final prevChatDate = DateTime.parse(chats[index - 1].time ?? "");
                        if (!isSameDay(chatDate, prevChatDate)) {
                          showDateHeader = true;
                        }
                      }
                      // Convert ngày ra dạng text đẹp
                      String formattedDate = formatDateHeader(chatDate);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (showDateHeader) DateHeader(text: formattedDate),
                          Padding(
                            padding: EdgeInsets.all(PaddingSizes.p8),
                            child: Align(
                              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                              child: MessageBubble(
                                message: chat.message ?? '',
                                isMe: isMe,
                                onEdit: () => _onEditMessage(chat),
                                onDelete: () => _onDeleteMessage(chat),
                              ),
                            ),
                          ),
                        ],
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
                        onTapOutside: (_) {
                          FocusScope.of(context).unfocus();
                        },
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: AppStrings.enterMessage.tr(),
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
