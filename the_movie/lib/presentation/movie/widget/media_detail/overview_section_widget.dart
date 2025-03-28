import 'package:flutter/material.dart';
import 'package:the_movie/data/models/media_detail/detail_movie.dart';

class OverviewSection extends StatelessWidget {
  final String tagline;
  final String overview;

  const OverviewSection(
      {super.key, required this.tagline, required this.overview});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          if (tagline.isNotEmpty)
            Text(
              tagline,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 212, 208, 208),
                fontStyle: FontStyle.italic,
              ),
            ),
          const SizedBox(height: 10),
          const Text(
            "Overview",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            overview ?? "No overview available.",
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
