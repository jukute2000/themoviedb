import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/core/utils/text_manager.dart';
import 'package:the_movie/presentation/home/bloc/switch/switch_cubit.dart';
import 'package:the_movie/presentation/theme/screen/app_style_provider.dart';

import '../../../core/configs/assets/app_strings.dart';

class SwitchButton extends StatelessWidget {
  const SwitchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwitchCubit, bool>(
      builder: (context, isTodaySelected) {
        return Container(
          padding: EdgeInsets.all(PaddingSizes.p4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.boderContainer, width: 1.5.w),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => context.read<SwitchCubit>().selectToday(),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 8.w),
                  decoration: BoxDecoration(
                    color: isTodaySelected
                        ? AppColors.todaySelected
                        : AppColors.textGrey,
                    borderRadius: BorderRadius.circular(RadiusSizes.r16),
                  ),
                  child: Text(
                    AppStrings.today.tr(),
                    style: TextManager.textStyleBlod(TextSizes.s16).copyWith(
                      color: isTodaySelected
                          ? AppStyleProvider.of(context).iconColor()
                          : AppColors.textWhite,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => context.read<SwitchCubit>().selectThisWeek(),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 8.w),
                  decoration: BoxDecoration(
                    color: !isTodaySelected
                        ? AppColors.todaySelected
                        : AppColors.textGrey,
                    borderRadius: BorderRadius.circular(RadiusSizes.r16),
                  ),
                  child: Text(
                    AppStrings.week.tr(),
                    style: TextManager.textStyleBlod(TextSizes.s16).copyWith(
                      color: !isTodaySelected
                          ? AppStyleProvider.of(context).iconColor()
                          : AppColors.textWhite,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
