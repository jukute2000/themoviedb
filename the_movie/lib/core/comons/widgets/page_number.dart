import 'package:flutter/material.dart';

import '../../utils/sizes_manager.dart';

class PageNumber extends StatelessWidget {
  final int? page;
  final bool isChoose;
  final Function(int?) onPageChanged;

  const PageNumber({super.key, required this.page, required this.isChoose, required this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPageChanged(page!);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: MarginSizes.m8),
        padding: EdgeInsets.all(PaddingSizes.p8),
        decoration: BoxDecoration(
          color: isChoose ? Colors.grey[300] : Colors.transparent,
          borderRadius: BorderRadius.circular(RadiusSizes.r8),
        ),
        child: Text(
          "$page",
          style: TextStyle(
            color: isChoose ? Colors.black : Colors.grey,
            fontWeight: isChoose ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
