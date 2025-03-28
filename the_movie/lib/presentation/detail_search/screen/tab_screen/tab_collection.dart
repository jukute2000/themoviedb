import 'package:flutter/material.dart';
import 'package:the_movie/data/models/search/search_collections.dart';
import 'package:the_movie/presentation/detail_search/widget/collection_widget.dart';

import '../../../../core/comons/widgets/page_number.dart';
import '../../../../data/models/collection/collection.dart';

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
                return CollectionWidget(
                  title: collection.name ?? '',
                  overview: '',
                  posterPath: collection.posterPath ?? '',
                );
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.collectionData.page! > 1)
              IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: () {
                  widget.onPageChanged(widget.collectionData.page! - 1);
                },
              ),
            PageNumber(
              page: 1,
              isChoose: widget.collectionData.page == 1,
              onPageChanged: (_) {
                widget.onPageChanged(1);
              },
            ),
            if (widget.collectionData.page! > 3) Text('...'),
            if (widget.collectionData.page! > 2)
              PageNumber(
                page: widget.collectionData.page! - 1,
                isChoose: false,
                onPageChanged: (_) {
                  widget.onPageChanged(widget.collectionData.page! - 1);
                },
              ),
            if (widget.collectionData.page != 1 &&
                widget.collectionData.page != widget.collectionData.totalPages)
              PageNumber(
                page: widget.collectionData.page!,
                isChoose: true,
                onPageChanged: (_) {
                  widget.onPageChanged(widget.collectionData.page!);
                },
              ),
            if (widget.collectionData.page! <
                widget.collectionData.totalPages! - 1)
              PageNumber(
                page: widget.collectionData.page! + 1,
                isChoose: false,
                onPageChanged: (_) {
                  widget.onPageChanged(widget.collectionData.page! + 1);
                },
              ),
            if (widget.collectionData.page! <
                widget.collectionData.totalPages! - 2)
              Text('...'),
            PageNumber(
              page: widget.collectionData.totalPages,
              isChoose: widget.collectionData.page ==
                  widget.collectionData.totalPages,
              onPageChanged: (_) {
                widget.onPageChanged(widget.collectionData.totalPages);
              },
            ),
            if ((widget.collectionData.page ?? 0) <
                (widget.collectionData.totalPages ?? 0))
              IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () {
                  widget.onPageChanged(widget.collectionData.page! + 1);
                },
              ),
          ],
        )
      ],
    );
  }
}
