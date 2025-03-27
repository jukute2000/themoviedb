import 'package:flutter/material.dart';

import '../../utils/sizes_manager.dart';

class KeywordContainer extends StatelessWidget {
  final String keyword;
  final bool isSelected;

  const KeywordContainer(
      {super.key, required this.keyword, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(PaddingSizes.p4),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.5),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(color: isSelected ? Colors.blue : Colors.grey[300]!),
        borderRadius: BorderRadius.circular(RadiusSizes.r8),
      ),
      child: Text(
        keyword,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
