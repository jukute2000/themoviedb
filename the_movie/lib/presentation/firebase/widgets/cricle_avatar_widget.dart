import 'package:flutter/material.dart';

import '../../../core/configs/assets/app_colors.dart';

class CricleAvatarWidget extends StatelessWidget {
  const CricleAvatarWidget({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    final bgColor = AppColors.getRandomColor();
    final textColor = AppColors.getTextColor(bgColor);
    return CircleAvatar(
      backgroundColor: bgColor,
      child: Text(
        name,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
