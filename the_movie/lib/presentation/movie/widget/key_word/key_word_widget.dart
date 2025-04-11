import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/data/models/keyword/keyword.dart';

import '../../../../core/configs/assets/app_strings.dart';
import '../../../../core/utils/sizes_manager.dart';
import '../../../../core/utils/text_manager.dart';

class KeyWordWidget1 extends StatefulWidget {
  final List<Keyword> keywords;

  const KeyWordWidget1({
    super.key,
    required this.keywords,
  });

  @override
  State<KeyWordWidget1> createState() => _KeyWordWidget1State();
}

class _KeyWordWidget1State extends State<KeyWordWidget1> {
  int? selectedKeywordId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widget.keywords.map((keyword) {
            final isSelected = selectedKeywordId == keyword.id;

            return Padding(
              padding: EdgeInsets.all(PaddingSizes.p4),
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedKeywordId = keyword.id;
                  });
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.containerKeyWordSelected
                        : AppColors.containerKeyWordUnSelected,
                    borderRadius: BorderRadius.circular(RadiusSizes.r8),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.borderSelected
                          : AppColors.borderUnSelected,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    keyword.name ?? AppStrings.noInfomation.tr(),
                    style: TextManager.textStyleMedium(TextSizes.s16).copyWith(
                      color: isSelected
                          ? AppColors.textKeywordSelected
                          : AppColors.textKeywordUnSelected,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
