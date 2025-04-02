import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';

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
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textTagLine,
                fontStyle: FontStyle.italic,
              ),
            ),
          GapsManager.h10,
          Text(
            "Overview",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textWhite,
            ),
          ),
          GapsManager.h10,
          Text(
            overview,
            style: const TextStyle(color: AppColors.textWhite70),
          ),
        ],
      ),
    );
  }
}
