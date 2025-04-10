import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/utils/text_manager.dart';

import '../../../../core/utils/sizes_manager.dart';

class TitleSection extends StatelessWidget {
  final DateTime releaseDate;
  final String title;

  const TitleSection(
      {super.key, required this.releaseDate, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              title,
              style: TextManager.textStyleBlod(TextSizes.s32)
                  .copyWith(color: AppColors.textWhite),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            "(${releaseDate.year})",
            style: TextManager.textStyleMedium(TextSizes.s24)
                .copyWith(color: AppColors.textWhite),
          ),
        ],
      ),
    );
  }
}
