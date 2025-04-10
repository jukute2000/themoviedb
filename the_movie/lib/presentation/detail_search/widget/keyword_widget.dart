import 'package:flutter/material.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/core/utils/text_manager.dart';

class KeywordWidget extends StatelessWidget {
  final String keyword;
  const KeywordWidget({super.key, required this.keyword});

  @override
  Widget build(BuildContext context) {
    return Text(keyword, style: TextManager.textStyleMedium(TextSizes.s16));
  }
}
