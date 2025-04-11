import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';

import '../../../../core/configs/assets/app_strings.dart';
import '../../../../core/utils/text_manager.dart';

class OverviewSection extends StatelessWidget {
  final String tagline;
  final String overview;

  const OverviewSection(
      {super.key, required this.tagline, required this.overview});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(PaddingSizes.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GapsManager.h10,
          if (tagline.isNotEmpty)
            Text(
              tagline,
              style: TextManager.textStyleMedium(TextSizes.s24).copyWith(
                color: AppColors.textWhite,
              ),
            ),
          GapsManager.h10,
          Text(
            AppStrings.overview.tr(),
            style: TextManager.textStyleBlod(TextSizes.s24).copyWith(
              color: AppColors.textWhite,
            ),
          ),
          GapsManager.h10,
          Text(
            overview,
            style: TextManager.textStyleRegular(TextSizes.s16).copyWith(
              color: AppColors.textWhite70,
            ),
          ),
        ],
      ),
    );
  }
}
