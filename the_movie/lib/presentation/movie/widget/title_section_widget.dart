import 'package:flutter/material.dart';
import 'package:the_movie/data/models/media_detail/detail_movie.dart';

class TitleSection extends StatelessWidget {
  final DetailMovie movie;

  const TitleSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              "${movie.title} ",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            "(${movie.releaseDate?.year ?? 'N/A'})",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
