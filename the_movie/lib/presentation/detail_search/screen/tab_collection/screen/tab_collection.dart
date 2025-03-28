import 'package:flutter/material.dart';
import 'package:the_movie/data/models/search/search_collections.dart';
import 'package:the_movie/presentation/detail_search/widget/tab_view_widget.dart';

import '../../../../../data/models/collection/collection.dart';
import '../../../widget/pagination_controller.dart';

class TabCollection extends StatefulWidget {
  final SearchCollections collectionData;
  final Function(int?) onPageChanged;

  const TabCollection(
      {super.key, required this.collectionData, required this.onPageChanged});

  @override
  State<TabCollection> createState() => _TabCollectionState();
}

class _TabCollectionState extends State<TabCollection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: widget.collectionData.collections?.length,
              itemBuilder: (context, index) {
                Collection collection = widget.collectionData.collections![index];
                return TabViewWidget(
                  media: collection,
                );
              }),
        ),
        PaginationControls(
          currentPage: widget.collectionData.page ?? 1,
          totalPages: widget.collectionData.totalPages ?? 1,
          onPageChanged: widget.onPageChanged,
        ),
      ],
    );
  }
}
