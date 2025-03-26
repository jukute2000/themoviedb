import 'package:flutter/material.dart';
import 'package:the_movie/presentation/detail_search/widget/collection_widget.dart';


class TabCollection extends StatefulWidget {
  final String query;

  const TabCollection({super.key, required this.query});

  @override
  State<TabCollection> createState() => _TabCollectionState();
}

class _TabCollectionState extends State<TabCollection> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) => CollectionWidget(
          title: 'Ready',
          overview:
          'Batman must face his most ruthless nemesis when a deformed madman calling himself \"The Joker\" seizes control of Gothams criminal underworld.',
          posterPath: '',
        ));
  }
}