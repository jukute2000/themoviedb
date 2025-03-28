import 'package:flutter/material.dart';

class InfoSection extends StatelessWidget {
  final String releaseDateText;
  final String originText;
  final String runtimeText;
  final String genreText;

  const InfoSection(
      {super.key,
      required this.releaseDateText,
      required this.originText,
      required this.runtimeText,
      required this.genreText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCertification(),
              _buildRuntimeInfo(),
              _buildTrailerButton(),
            ],
          ),
          _buildGenreText(),
        ],
      ),
    );
  }

  Widget _buildCertification() {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        border: Border.all(
          color: const Color.fromARGB(255, 207, 207, 207),
          width: 1,
        ),
      ),
      child: const Text(
        'PG',
        style: TextStyle(
          color: Color.fromARGB(255, 207, 207, 207),
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildRuntimeInfo() {
    return Expanded(
      child: Text(
        " ${releaseDateText} (${originText}) • ${runtimeText}",
        style: const TextStyle(color: Colors.white, fontSize: 16),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildTrailerButton() {
    return const Row(
      children: [
        Icon(Icons.play_arrow, color: Colors.white, size: 17),
        TextButton(
          onPressed: null,
          child: Text(
            "Play Trailer",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildGenreText() {
    return Text(
      genreText,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }
}
