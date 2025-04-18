import 'package:flutter/material.dart';
import 'package:the_movie/presentation/firebase/widgets/appbar.dart';
import 'package:the_movie/data/models/chat/detail_chat.dart';

import '../../../data/repositories/chat/chat_repository.dart';

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
    super.dispose();
  }

  void _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    await ChatRepositoryImpl.instance.addDetailMessage(widget.chatRoomId, message);

    _messageController.clear();

    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
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
                stream: ChatRepositoryImpl.instance.getListDetailChat(widget.chatRoomId),
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
                      final isMe = chat.idSend == ChatRepositoryImpl.instance.user?.uid;

                      return Align(
                        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blueAccent : Colors.grey[300],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            chat.message ?? '',
                            style: TextStyle(
                              color: isMe ? Colors.white : Colors.black87,
                            ),
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
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: "Nhập tin nhắn...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
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
