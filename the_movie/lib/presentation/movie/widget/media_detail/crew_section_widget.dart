import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import '../../../../core/configs/assets/app_colors.dart';
import '../../../../core/configs/assets/app_strings.dart';
import '../../../../core/utils/text_manager.dart';

class CrewSection extends StatelessWidget {
  const CrewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(PaddingSizes.p16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _InfoPerson(name: "Marc Webb", role: AppStrings.director.tr()),
          _InfoPerson(
              name: "Erin Cressida Wilson", role: AppStrings.screenplay.tr()),
        ],
      ),
    );
  }
}

class _InfoPerson extends StatelessWidget {
  final String name;
  final String role;

  const _InfoPerson({required this.name, required this.role});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextManager.textStyleBlod(TextSizes.s16).copyWith(
            color: AppColors.textWhite,
          ),
        ),
        Text(
          role,
          style: TextManager.textStyleMedium(TextSizes.s16).copyWith(
            color: AppColors.textWhite70,
          ),
        ),
      ],
    );
  }
}
