import 'package:flutter/material.dart';
import 'package:the_movie/core/comons/widgets/keyword_container.dart';
import 'package:the_movie/core/configs/assets/app_images.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';

import '../../../core/utils/sizes_manager.dart';

class CompanyWidget extends StatelessWidget {
  final String? logoPath;
  final String name;
  final String? originCountry;

  const CompanyWidget(
      {super.key, this.logoPath, this.originCountry, required this.name});

  @override
  Widget build(BuildContext context) {
    return logoPath != null ? Row(
      children: [
        Image.asset(AppImages.splashBackground,
          width: WidthSizes.w50,
          height: HeightSizes.h50,
          fit: BoxFit.cover,),
        GapsManager.w20,
        KeywordContainer(keyword: name, isSelected: false),
      ],
    ) : Text(name);
  }
}
