import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/configs/assets/app_images.dart';
import 'package:the_movie/core/configs/assets/app_strings.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/presentation/detail_search/screen/detail_search_screen.dart';

import '../../../core/utils/sizes_manager.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

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
    return Stack(
      children: [
        Container(
          height: 250.h,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                AppImages.banerImage, // Đặt URL ảnh phim ở đây
              ),
              fit: BoxFit.cover,
            ),
          ),
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
                AppStrings.titleDashboard1,
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textWhite,
                ),
              ),
              Text(
                AppStrings.titleDashboard2,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: AppColors.textWhite,
                ),
              ),
              GapsManager.h20,
              Container(
                padding: EdgeInsets.all(PaddingSizes.p4),
                decoration: BoxDecoration(
                  color: AppColors.containerWhite,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textController,
                        decoration: const InputDecoration(
                          hintText: "Search...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.search, color: AppColors.iconSerach),
                      onPressed: () {
                        String text = textController.text;
                        AppNavigator.push(
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
