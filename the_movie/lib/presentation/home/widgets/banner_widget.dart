import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/configs/assets/app_images.dart';
import 'package:the_movie/core/configs/assets/app_strings.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/core/utils/text_manager.dart';
import 'package:the_movie/presentation/detail_search/screen/detail_search_screen.dart';
import 'package:the_movie/presentation/home/bloc/banner/banner_state.dart';

import '../../../core/utils/sizes_manager.dart';
import '../bloc/banner/banner_cubit.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key, required this.focusNode});
  final FocusNode focusNode;

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BannerCubit()..loadBanner(),
      child: Stack(
        children: [
          BlocBuilder<BannerCubit, BannerState>(
            //widget image chung
            builder: (context, state) {
              if (state is BannerIsLoading) {
                return Container(
                  height: 250.h,
                  color: AppColors.overlayBanner,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is BannerLoaded) {
                return Container(
                  height: 250.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(state.images!),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              } else if (state is BannerError) {
                return Container(
                  height: 250.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.noImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink(); // Default return statement
            },
          ),
          Container(
            height: 250.h,
            color: AppColors.overlayBanner,
          ),
          Positioned(
            top: 50.h,
            left: 20.w,
            right: 20.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.titleDashboard1.tr(),
                  style: TextManager.textStyleBlod(TextSizes.s32)
                      .copyWith(color: AppColors.textWhite),
                ),
                Text(
                  AppStrings.titleDashboard2.tr(),
                  style: TextManager.textStyleMedium(TextSizes.s16)
                      .copyWith(color: AppColors.textWhite),
                ),
                GapsManager.h20,
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.containerWhite,
                    borderRadius: BorderRadius.circular(RadiusSizes.r32),
                  ),
                  child: TextField(
                    onTapOutside: (event) {
                      widget.focusNode.unfocus();
                    },
                    controller: textController,
                    focusNode: widget.focusNode,
                    style: TextManager.textStyleMedium(TextSizes.s16)
                        .copyWith(
                      color: AppColors.textBlack,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: PaddingSizes.p16,
                        vertical: PaddingSizes.p16, // chỉnh cho chiều cao vừa ý
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (textController.text.isNotEmpty)
                            IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                textController.clear();
                                FocusScope.of(context).unfocus();
                              },
                            ),
                          IconButton(
                            icon: const Icon(Icons.search, color: AppColors.iconSerach),
                            onPressed: () {
                              String text = textController.text;
                              AppNavigator.pushAndRemove(
                                context,
                                DetailSearchScreen(
                                  index: 0,
                                  query: text,
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      hintText: AppStrings.search.tr(),
                      hintStyle:
                          TextManager.textStyleMedium(TextSizes.s16)
                              .copyWith(
                        color: AppColors.textBlack,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
