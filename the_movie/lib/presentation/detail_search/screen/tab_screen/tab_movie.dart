import 'package:flutter/material.dart';
import 'package:the_movie/presentation/detail_search/widget/movie_widget.dart';


class TabMovie extends StatefulWidget {
  final String query;

  const TabMovie({super.key, required this.query});

  @override
  State<TabMovie> createState() => _TabMovieState();
}

class _TabMovieState extends State<TabMovie> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) => MovieWidget(
          title: 'Ready',
          releaseDate: DateTime(1989,06,21),
          overview:
          'Batman must face his most ruthless nemesis when a deformed madman calling himself \"The Joker\" seizes control of Gothams criminal underworld.',
          posterPath: '',
        ));
  }
}