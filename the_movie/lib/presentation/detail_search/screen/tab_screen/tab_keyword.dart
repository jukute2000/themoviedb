import 'package:flutter/material.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/presentation/detail_search/widget/keyword_widget.dart';

class TabKeyword extends StatefulWidget {
  final String query;

  const TabKeyword({super.key, required this.query});

  @override
  State<TabKeyword> createState() => _TabKeywordState();
}

class _TabKeywordState extends State<TabKeyword> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(PaddingSizes.p24),
      child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) => KeywordWidget(
                keyword: 'Ready',
              )),
    );
  }
}
