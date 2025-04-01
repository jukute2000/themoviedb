import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final Widget? widget;
  final double fontSize;
  const TitleWidget(
      {super.key, required this.title, this.widget, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          widget ?? const SizedBox(),
        ],
      ),
    );
  }
}
