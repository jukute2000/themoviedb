import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/utils/text_manager.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final Widget? widget;
  final double fontSize;
  const TitleWidget(
      {super.key, required this.title, this.widget, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.h, vertical: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextManager.textStyleBlack(fontSize),
          ),
          widget ?? const SizedBox(),
        ],
      ),
    );
  }
}
