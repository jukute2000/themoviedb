import 'package:flutter/material.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/data/models/keyword/keyword.dart';
import 'package:the_movie/data/models/search/search_keywords.dart';
import 'package:the_movie/presentation/detail_search/widget/keyword_widget.dart';

import '../../../../core/comons/widgets/page_number.dart';

class TabKeyword extends StatefulWidget {
  final SearchKeywords keywordData;
  final Function(int?) onPageChanged;

  const TabKeyword({
    super.key,
    required this.keywordData,
    required this.onPageChanged,
  });

  @override
  State<TabKeyword> createState() => _TabKeywordState();
}

class _TabKeywordState extends State<TabKeyword> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(PaddingSizes.p24),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: widget.keywordData.keywords?.length,
                itemBuilder: (context, index) {
                  Keyword? keyword = widget.keywordData.keywords?[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: PaddingSizes.p8),
                    child: KeywordWidget(
                      keyword: keyword?.name ?? '',
                    ),
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.keywordData.page! > 1)
                IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    widget.onPageChanged(widget.keywordData.page! - 1);
                  },
                ),
              PageNumber(
                page: 1,
                isChoose: widget.keywordData.page == 1,
                onPageChanged: (_) {
                  widget.onPageChanged(1);
                },
              ),
              if (widget.keywordData.page! > 3) Text('...'),
              if (widget.keywordData.page! > 2)
                PageNumber(
                  page: widget.keywordData.page! - 1,
                  isChoose: false,
                  onPageChanged: (_) {
                    widget.onPageChanged(widget.keywordData.page! - 1);
                  },
                ),
              if (widget.keywordData.page != 1 &&
                  widget.keywordData.page != widget.keywordData.totalPages)
                PageNumber(
                  page: widget.keywordData.page!,
                  isChoose: true,
                  onPageChanged: (_) {
                    widget.onPageChanged(widget.keywordData.page!);
                  },
                ),
              if (widget.keywordData.page! < widget.keywordData.totalPages! - 1)
                PageNumber(
                  page: widget.keywordData.page! + 1,
                  isChoose: false,
                  onPageChanged: (_) {
                    widget.onPageChanged(widget.keywordData.page! + 1);
                  },
                ),
              if (widget.keywordData.page! < widget.keywordData.totalPages! - 2)
                Text('...'),
              PageNumber(
                page: widget.keywordData.totalPages,
                isChoose: widget.keywordData.page ==
                    widget.keywordData.totalPages,
                onPageChanged: (_) {
                  widget.onPageChanged(widget.keywordData.totalPages);
                },
              ),
              if ((widget.keywordData.page ?? 0) <
                  (widget.keywordData.totalPages ?? 0))
                IconButton(
                  icon: Icon(Icons.chevron_right),
                  onPressed: () {
                    widget.onPageChanged(widget.keywordData.page! + 1);
                  },
                ),
            ],
          )
        ],
      ),
    );
  }
}
