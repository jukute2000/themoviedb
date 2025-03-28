import 'package:flutter/material.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/data/models/keyword/keyword.dart';
import 'package:the_movie/data/models/search/search_keywords.dart';
import 'package:the_movie/presentation/detail_search/widget/keyword_widget.dart';

import '../../../widget/pagination_controller.dart';

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
          PaginationControls(
            currentPage: widget.keywordData.page ?? 1,
            totalPages: widget.keywordData.totalPages ?? 1,
            onPageChanged: widget.onPageChanged,
          ),
        ],
      ),
    );
  }
}
