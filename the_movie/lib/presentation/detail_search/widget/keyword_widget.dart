import 'package:flutter/material.dart';

class KeywordWidget extends StatelessWidget {
  final String keyword;
  const KeywordWidget({super.key, required this.keyword});

  @override
  Widget build(BuildContext context) {
    return Text(keyword);
  }
}
