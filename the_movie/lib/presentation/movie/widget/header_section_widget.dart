import 'package:flutter/material.dart';
import 'package:the_movie/data/models/media_detail/detail_movie.dart';

class HeaderSection extends StatelessWidget {
  final DetailMovie movie;

  const HeaderSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(240, 0, 20, 0),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          _buildBackdropImage(),
          _buildPosterImage(),
        ],
      ),
    );
  }

  Widget _buildBackdropImage() {
    return Image.network(
      "https://image.tmdb.org/t/p/w780${movie.backdropPath}",
      width: double.infinity,
      height: 200,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        width: double.infinity,
        height: 200,
        color: Colors.grey[800],
        child: const Center(
          child: Text('Image not available',
              style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildPosterImage() {
    return Positioned(
      left: 16,
      bottom: 16,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.network(
          "https://image.tmdb.org/t/p/w200${movie.posterPath}",
          width: 80,
          height: 120,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            width: 80,
            height: 120,
            color: Colors.grey[700],
            child: const Icon(Icons.image_not_supported, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
