import 'package:flutter/material.dart';
import '../detail/bubble_chat/bubble_recipient.dart';
import '../detail/bubble_chat/bubble_sender.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const MessageBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: isMe ? BlueBubblePainter() : GreyBubblePainter(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          message,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}