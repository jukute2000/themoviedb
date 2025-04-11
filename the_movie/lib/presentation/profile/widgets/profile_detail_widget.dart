import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/configs/assets/app_strings.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/data/models/account/account_model.dart';

import '../../../core/utils/sizes_manager.dart';
import '../../../core/utils/text_manager.dart';

class ProfileDetailWidget extends StatelessWidget {
  final AccountModel accountModel;
  const ProfileDetailWidget({super.key, required this.accountModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Avatar
            Padding(
              padding: EdgeInsets.all(PaddingSizes.p8),
              child: CircleAvatar(
                radius: 50.r,
                child: Text(
                  'L',
                  style: TextManager.textStyleBlod(TextSizes.s32).copyWith(
                    color: AppColors.textWhite,
                  ),
                ),
              ),
            ),
            GapsManager.h10,
            // Tên người dùng
            Padding(
              padding: EdgeInsets.all(PaddingSizes.p8),
              child: Text(
                accountModel.username,
                style: TextManager.textStyleBlod(TextSizes.s20),
              ),
            ),
            GapsManager.h10,
            // Thành viên từ
            Padding(
              padding: EdgeInsets.all(PaddingSizes.p8),
              child: Text(
                AppStrings.memberSince.tr(),
                style: TextManager.textStyleMedium(TextSizes.s16),
              ),
            ),

            // Điểm số
            Padding(
              padding: EdgeInsets.all(PaddingSizes.p8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScoreWidget(score: 50, label: AppStrings.movieScore.tr()),
                  GapsManager.w40,
                  ScoreWidget(score: 75, label: AppStrings.tvScore.tr()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScoreWidget extends StatelessWidget {
  final int score;
  final String label;

  const ScoreWidget({super.key, required this.score, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 60.w,
                height: 60.h,
                child: CircularProgressIndicator(
                  value: score / 100,
                  strokeWidth: 6,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    score >= 75
                        ? AppColors.ratingGreen
                        : AppColors.ratingYellow,
                  ),
                ),
              ),
              Text(
                '$score*',
                style: TextManager.textStyleMedium(16.sp),
              ),
            ],
          ),
          GapsManager.h10,
          Padding(
            padding: EdgeInsets.all(PaddingSizes.p8),
            child: Text(
              '${AppStrings.medium.tr()}\n$label',
              textAlign: TextAlign.center,
              style: TextManager.textStyleMedium(14.sp),
            ),
          ),
        ],
      ),
    );
  }
}
