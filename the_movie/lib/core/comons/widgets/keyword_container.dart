import 'package:flutter/material.dart';
import 'package:the_movie/core/utils/text_manager.dart';
import 'package:the_movie/presentation/theme/screen/app_style_provider.dart';

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
        color: Colors.grey[600],
        border: Border.all(color: isSelected ? Colors.blue : Colors.grey[300]!),
        borderRadius: BorderRadius.circular(RadiusSizes.r8),
      ),
      child: Text(
        keyword,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextManager.textStyleMedium(TextSizes.s16)
            .copyWith(color: AppStyleProvider.of(context).textColor()),
      ),
    );
  }
}
