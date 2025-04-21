import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import '../../../core/configs/assets/app_strings.dart';
import '../detail/bubble_chat/bubble_recipient.dart';
import '../detail/bubble_chat/bubble_sender.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: isMe
          ? () {
              _showOptions(context);
            }
          : null,
      child: CustomPaint(
        painter: isMe ? BlueBubblePainter() : GreyBubblePainter(),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: PaddingSizes.p16, vertical: PaddingSizes.p8),
          margin: EdgeInsets.symmetric(vertical: MarginSizes.m8),
          child: Text(
            message,
            softWrap: true,
            style: const TextStyle(
              color: AppColors.textWhite,
            ),
          ),
        ),
      ),
    );
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(RadiusSizes.r16)),
      ),
      builder: (BuildContext ctx) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit, color: AppColors.iconAppbar),
              title: Text(AppStrings.editMessage.tr()),
              onTap: () {
                Navigator.pop(ctx);
                if (onEdit != null) {
                  onEdit!();
                }
              },

            ),
            ListTile(
              leading: const Icon(Icons.delete, color: AppColors.iconChoose),
              title: Text(AppStrings.deleteMessage.tr()),
              onTap: () {
                Navigator.pop(ctx);
                if (onDelete != null) {
                  onDelete!();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
