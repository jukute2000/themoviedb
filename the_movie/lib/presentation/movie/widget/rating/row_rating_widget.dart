import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/data/models/account/account_status.dart';
import 'package:the_movie/presentation/movie/bloc/account_status/account_status_cubit.dart';
import 'package:the_movie/presentation/movie/widget/rating/rating_over_lay.dart';

import '../../../../core/configs/assets/app_strings.dart';
import '../../../../core/utils/sizes_manager.dart';
import '../../../../core/utils/text_manager.dart';

class RowRatingWidget extends StatefulWidget {
  final bool isMovie;
  final AccountStatus accountStatus;
  const RowRatingWidget(
      {super.key, required this.accountStatus, required this.isMovie});

  @override
  State<RowRatingWidget> createState() => _RowRatingWidgetState();
}

class _RowRatingWidgetState extends State<RowRatingWidget> {
  late String text;
  late AccountStatus currentStatus;
  late double userScore;

  @override
  void initState() {
    super.initState();
    currentStatus = widget.accountStatus;
    userScore = currentStatus.hasRating ? currentStatus.ratingValue! : 10;
    text = currentStatus.hasRating
        // viet ham tai su dung
        ? "${AppStrings.yourVibe.tr()} ${(userScore * 10).round()}%"
        : AppStrings.whatsYourVibe.tr();
  }

  void _showRatingOverlay(double userScoreF) {
    final parentContext = context;
    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      backgroundColor: AppColors.containerWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Builder(builder: (context) {
          return RatingOverlay(
            initialScore: userScoreF,
            onRatingSelected: (newScore) {
              setState(() {
                userScore = newScore;
                text =
                    "${AppStrings.yourVibe.tr()} ${(userScore * 10).round()}%";
              });
              parentContext
                  .read<AccountStatusCubit>()
                  .rateMovie(widget.accountStatus.id, newScore, widget.isMovie);
            },
            resetRating: (newScore) {
              setState(() {
                text = AppStrings.whatsYourVibe.tr();
              });
              parentContext
                  .read<AccountStatusCubit>()
                  .deleteRate(widget.accountStatus.id, widget.isMovie);
            },
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _emojiIcon("😡"),
        _emojiIcon("🤢"),
        _emojiIcon("🤩"),
        SizedBox(
          height: 20.h,
          child: VerticalDivider(
              color: AppColors.verticalDevicde, thickness: 1.5, width: 10.w),
        ),
        GestureDetector(
            onTap: () => _showRatingOverlay(userScore * 10),
            child: Text(
              text,
              style: TextManager.textStyleMedium(TextSizes.s18).copyWith(
                color: AppColors.textWhite,
              ),
            )),
        Icon(Icons.info_outline, color: AppColors.iconNotSuport, size: 17.w),
      ],
    );
  }

  Widget _emojiIcon(String emoji) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Text(emoji, style: TextManager.textStyleMedium(TextSizes.s20)),
    );
  }
}
