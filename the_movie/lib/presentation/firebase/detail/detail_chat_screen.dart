import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:the_movie/core/comons/widgets/format_date.dart';
import 'package:the_movie/core/configs/assets/app_strings.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/presentation/firebase/widgets/appbar.dart';
import 'package:the_movie/data/models/chat/detail_chat.dart';
import 'package:the_movie/presentation/firebase/widgets/custom_text_field.dart';

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
  Map<String, String> _userNames = {};

  @override
  void initState() {
    _scrollController = ScrollController();
    _messageController = TextEditingController();
    _loadUsers();
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

  void _loadUsers() async {
    final users = await ChatRepositoryImpl.instance.getListUser();
    if (!mounted) return;
    if (users != null) {
      setState(() {
        _userNames = {for (var user in users) user.id ?? '': user.name ?? ''};
        if (ChatRepositoryImpl.instance.user != null) {
          _userNames[ChatRepositoryImpl.instance.user!.uid] =
              ChatRepositoryImpl.instance.user!.displayName ??
                  AppStrings.me.tr();
        }
      });
    }
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
      if (mounted) {
        _messageController.clear();
      }
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!mounted) return;
        _scrollToBottom();
      });
    } catch (e, stack) {
      debugPrint('Send message error: $e');
      debugPrintStack(stackTrace: stack);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Gửi tin nhắn thất bại. Vui lòng thử lại.')),
        );
      }
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
        chat.messageId,
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
        chat.messageId,
      );
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
                      final senderName =
                          _userNames[chat.idSend] ?? AppStrings.other.tr();
                      // Lấy ngày gửi
                      final chatDate = chat.getDateHeader();
                      // So với ngày tin nhắn trước
                      bool showDateHeader = false;
                      if (index == 0) {
                        showDateHeader = true;
                      } else {
                        final prevChatDate = chats[index - 1].getDateHeader();
                        if (!FormatDate.isSameDay(chatDate, prevChatDate)) {
                          showDateHeader = true;
                        }
                      }
                      // Convert ngày ra dạng text đẹp
                      String formattedDate =
                          FormatDate.formatDateHeader(chatDate);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (showDateHeader) DateHeader(text: formattedDate),
                          Padding(
                            padding: EdgeInsets.all(PaddingSizes.p8),
                            child: Align(
                              alignment: isMe
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: isMe
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  MessageBubble(
                                    message: chat.message ?? '',
                                    isMe: isMe,
                                    onEdit: () => _onEditMessage(chat),
                                    onDelete: () => _onDeleteMessage(chat),
                                  ),
                                  GapsManager.h5,
                                  Text(
                                    isMe ? AppStrings.me.tr() : senderName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.grey,
                                          fontSize: TextSizes.s12,
                                        ),
                                  ),
                                ],
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
                      child: CustomTextField(controller: _messageController),
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
