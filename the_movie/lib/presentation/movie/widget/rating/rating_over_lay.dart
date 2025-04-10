// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/core/utils/text_manager.dart';

class RatingOverlay extends StatefulWidget {
  final double initialScore;
  final Function(double) onRatingSelected;
  final Function(double) resetRating;

  const RatingOverlay({
    super.key,
    required this.initialScore,
    required this.onRatingSelected,
    required this.resetRating,
  });

  @override
  State<RatingOverlay> createState() => _RatingOverlayState();
}

class _RatingOverlayState extends State<RatingOverlay> {
  late double rating;
  late Map<String, IconData> moodIcons;
  late String selectedMood;

  @override
  void initState() {
    super.initState();
    rating = widget.initialScore;
    moodIcons = {
      "Happy": Icons.emoji_emotions,
      "Interested": Icons.lightbulb,
      "Surprised": Icons.sentiment_satisfied_alt,
      "Sad": Icons.sentiment_dissatisfied,
    };
    selectedMood = "Happy"; // Default selected mood
  }

  // Get color based on rating value (red to green gradient)
  Color getRatingColor(double value) {
    // From red (0) to yellow (50) to green (100)
    if (value <= 50) {
      // From red to yellow (0-50)
      return Color.lerp(
          AppColors.ratingRed, AppColors.ratingYellow, value / 50)!;
    } else {
      // From yellow to green (50-100)
      return Color.lerp(
          AppColors.ratingYellow, AppColors.ratingGreen, (value - 50) / 50)!;
    }
  }

  String getRatingText(double value) {
    if (value < 20) return "Rất không hài lòng";
    if (value < 40) return "Không hài lòng";
    if (value < 60) return "Bình thường";
    if (value < 80) return "Hài lòng";
    return "Rất hài lòng";
  }

  @override
  Widget build(BuildContext context) {
    final Color currentColor = getRatingColor(rating);

    return Container(
      padding: EdgeInsets.all(PaddingSizes.p24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.containerWhite,
        boxShadow: const [
          BoxShadow(
            color: AppColors.boxShadowBlack,
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Đánh giá của bạn",
                style: TextManager.textStyleBlod(TextSizes.s20)
                    .copyWith(color: AppColors.textBlack),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.h,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  color:
                      currentColor.withOpacity(0.3), // sua lai thanh with value
                  borderRadius: BorderRadius.circular(RadiusSizes.r16),
                  border: Border.all(color: currentColor, width: 1),
                ),
                child: Text(
                  "${rating.toInt()}%",
                  style: TextManager.textStyleMedium(TextSizes.s16)
                      .copyWith(color: AppColors.textBlack),
                ),
              ),
            ],
          ),
          GapsManager.h10,
          Text(
            getRatingText(rating),
            style: TextManager.textStyleMedium(TextSizes.s16)
                .copyWith(color: AppColors.goodVoteItem),
          ),
          GapsManager.h10,
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: currentColor,
              inactiveTrackColor: Colors.grey.shade200,
              thumbColor: currentColor,
              overlayColor: currentColor.withOpacity(0.2),
              trackHeight: 8.h,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
            ),
            child: Slider(
              value: rating,
              min: 0,
              max: 100,
              divisions: 10, // 10 divisions from 0-100 (0, 10, 20, ..., 100)
              onChanged: (value) {
                setState(() {
                  rating = value;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("0%",
                  style: TextManager.textStyleMedium(TextSizes.s16)
                      .copyWith(color: AppColors.textGreyShade600)),
              Text("100%",
                  style: TextManager.textStyleMedium(TextSizes.s16)
                      .copyWith(color: AppColors.textGreyShade600)),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {
                widget.resetRating(rating / 10);
                Navigator.pop(context);
              },
              icon: Icon(Icons.refresh, size: 18.w),
              label: Text("Đặt lại",
                  style: TextManager.textStyleMedium(TextSizes.s16)
                      .copyWith(color: AppColors.textGreyShade600)),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.textGreyShade600,
              ),
            ),
          ),
          GapsManager.h10,
          Text(
            "Tâm trạng của bạn",
            style: TextManager.textStyleBlod(TextSizes.s20)
                .copyWith(color: AppColors.textBlack),
          ),
          GapsManager.h10,
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: moodIcons.entries.map((entry) {
              final bool isSelected = selectedMood == entry.key;
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    selectedMood = entry.key;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(PaddingSizes.p16),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? currentColor.withOpacity(0.2)
                        : AppColors.textGreyShade100,
                    borderRadius: BorderRadius.circular(RadiusSizes.r8),
                    border: Border.all(
                      color:
                          isSelected ? currentColor : AppColors.textTransparent,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        entry.value,
                        size: 36.w,
                        color: isSelected
                            ? currentColor
                            : AppColors.textGreyShade600,
                      ),
                      GapsManager.h10,
                      Text(
                        entry.key,
                        style: TextStyle(
                          fontSize: TextSizes.s16,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected
                              ? currentColor
                              : AppColors.textGreyShade800,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          GapsManager.h20,
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                widget.onRatingSelected(rating / 10);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: currentColor,
                foregroundColor: AppColors.foregroundRating,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(RadiusSizes.r32),
                ),
                elevation: 2,
              ),
              child: Text(
                "Hoàn tất",
                style: TextManager.textStyleBlod(TextSizes.s18)
                    .copyWith(color: AppColors.textWhite),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
