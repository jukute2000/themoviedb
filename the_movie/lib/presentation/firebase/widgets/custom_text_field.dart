import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:the_movie/core/configs/assets/app_strings.dart';

import '../../../core/utils/sizes_manager.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.controller});
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      controller: controller,
      decoration: InputDecoration(
        hintText: AppStrings.enterMessage.tr(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RadiusSizes.r32),
        ),
        contentPadding: EdgeInsets.symmetric(
            horizontal: PaddingSizes.p16, vertical: PaddingSizes.p8),
      ),
    );
  }
}
