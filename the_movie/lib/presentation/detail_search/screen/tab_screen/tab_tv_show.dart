import 'package:flutter/material.dart';

import '../../widget/tv_show_widget.dart';

class TabTvShow extends StatefulWidget {
  final String query;

  const TabTvShow({super.key, required this.query});

  @override
  State<TabTvShow> createState() => _TabTvShowState();
}

class _TabTvShowState extends State<TabTvShow> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) => TvShowWidget(
              title: 'Ready',
              originalName: 'Batman',
              releaseDate: DateTime(1989,06,21),
              overview:
                  'Batman must face his most ruthless nemesis when a deformed madman calling himself \"The Joker\" seizes control of Gothams criminal underworld.',
          posterPath: '',
            ));
  }
}
