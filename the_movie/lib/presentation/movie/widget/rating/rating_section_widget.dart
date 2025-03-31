import 'package:flutter/material.dart';
import 'package:the_movie/presentation/movie/widget/rating/rating_over_lay.dart';

class RatingSection extends StatefulWidget {
  final double voteAverage;

  const RatingSection({super.key, required this.voteAverage});

  @override
  State<RatingSection> createState() => RatingSectionState();
}

class RatingSectionState extends State<RatingSection> {
  double userScore = 40; // Mặc định user score

  void _showRatingOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return RatingOverlay(
          initialScore: userScore,
          onRatingSelected: (newScore) {
            setState(() {
              userScore = newScore;
            });
          },
        );
      },
    );
  }

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
          onTap: () => _showRatingOverlay(),
          child: const Text(
            "What's your Vibe?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
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
