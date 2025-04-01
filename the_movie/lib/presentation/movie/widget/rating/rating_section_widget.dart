import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/models/account/account_status.dart';
import 'package:the_movie/presentation/movie/bloc/account_status/account_status_cubit.dart';
import 'package:the_movie/presentation/movie/bloc/account_status/account_status_state.dart';
import 'package:the_movie/presentation/movie/widget/rating/rating_over_lay.dart';
import 'package:the_movie/presentation/movie/widget/rating/row_rating_widget.dart';

class RatingSection extends StatefulWidget {
  final bool isMovie;
  final double voteAverage;

  const RatingSection({super.key, required this.voteAverage, required this.isMovie});

  @override
  State<RatingSection> createState() => RatingSectionState();
}

class RatingSectionState extends State<RatingSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
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
        _ScoreCircle(score: widget.voteAverage),
        const SizedBox(width: 10),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("User", style: TextStyle(color: Colors.white, fontSize: 17)),
            Text("Score", style: TextStyle(color: Colors.white, fontSize: 17)),
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

class _ScoreCircle extends StatelessWidget {
  final double score;

  const _ScoreCircle({required this.score});

  @override
  Widget build(BuildContext context) {
    final Color progressColor = score >= 7
        ? Colors.green
        : score >= 5
            ? Colors.yellow
            : const Color.fromARGB(255, 185, 223, 15);

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 45,
          height: 45,
          child: CircularProgressIndicator(
            value: score / 10,
            backgroundColor: Colors.grey.shade800,
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            strokeWidth: 4,
          ),
        ),
        Text(
          "${(score * 10).toInt()}%",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
