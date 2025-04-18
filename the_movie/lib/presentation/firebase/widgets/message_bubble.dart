import 'package:flutter/material.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
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
        padding: EdgeInsets.symmetric(horizontal: PaddingSizes.p16, vertical: PaddingSizes.p8),
        margin: EdgeInsets.symmetric(vertical: MarginSizes.m8),
        child: Text(
          message,
          style: const TextStyle(
            color: AppColors.textWhite,
          ),
        ),
      ),
    );
  }
}