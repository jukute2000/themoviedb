import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/core/utils/text_manager.dart';
import 'package:the_movie/presentation/movie/bloc/account_status/account_status_cubit.dart';
import 'package:the_movie/presentation/movie/bloc/account_status/account_status_state.dart';
import 'package:the_movie/presentation/movie/widget/animation/bao_score_animation.dart';
import 'package:the_movie/presentation/movie/widget/rating/row_rating_widget.dart';

import '../../../../core/utils/sizes_manager.dart';

class RatingSection extends StatefulWidget {
  final bool isMovie;
  final double voteAverage;

  const RatingSection(
      {super.key, required this.voteAverage, required this.isMovie});

  @override
  State<RatingSection> createState() => RatingSectionState();
}

class RatingSectionState extends State<RatingSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(PaddingSizes.p16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildUserScore(),
          _buildVibeSection(),
        ],
      ),
    );
  }

  Widget _buildUserScore() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ScoreAnimation(score: (widget.voteAverage * 10).toInt()),
        GapsManager.w10,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("User",
                style: TextManager.textStyleMedium(TextSizes.s18).copyWith(
                  color: AppColors.textWhite,
                )),
            Text("Score",
                style: TextManager.textStyleMedium(TextSizes.s18).copyWith(
                  color: AppColors.textWhite,
                )),
          ],
        ),
      ],
    );
  }

  Widget _buildVibeSection() {
    return BlocBuilder<AccountStatusCubit, AccountStatusState>(
      builder: (context, state) {
        if (state is AccountStatusIsLoading) {
          return const CircularProgressIndicator();
        } else if (state is AccountStatusError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is AccountStatusLoaded) {
          return RowRatingWidget(
            accountStatus: state.accountStatus,
            isMovie: widget.isMovie,
          );
        }
        return const SizedBox();
      },
    );
  }
}
