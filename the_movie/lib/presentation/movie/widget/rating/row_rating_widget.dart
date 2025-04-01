import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/models/account/account_status.dart';
import 'package:the_movie/presentation/movie/bloc/account_status/account_status_cubit.dart';
import 'package:the_movie/presentation/movie/widget/rating/rating_over_lay.dart';

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
        ? "Your Vibe ${(userScore * 10).round()}%"
        : "What's your Vibe?";
  }

  void _showRatingOverlay(double userScoreF) {
    final parentContext = context;
    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      backgroundColor: Colors.white,
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
                text = "Your Vibe ${(userScore * 10).round()}%";
              });
              parentContext
                  .read<AccountStatusCubit>()
                  .rateMovie(widget.accountStatus.id, newScore, widget.isMovie);
            },
            resetRating: (newScore) {
              setState(() {
                text = "What's your Vibe?";
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
        const SizedBox(
          height: 20,
          child:
              VerticalDivider(color: Colors.white54, thickness: 1.5, width: 10),
        ),
        GestureDetector(
            onTap: () => _showRatingOverlay(userScore * 10),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            )),
        const Icon(Icons.info_outline, color: Colors.white, size: 17),
      ],
    );
  }

  Widget _emojiIcon(String emoji) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Text(emoji, style: const TextStyle(fontSize: 17)),
    );
  }
}
