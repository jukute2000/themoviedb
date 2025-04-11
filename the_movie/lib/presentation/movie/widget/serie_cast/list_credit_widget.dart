import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/configs/assets/app_images.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';

import 'package:the_movie/data/models/credits/credit.dart';

import 'package:the_movie/presentation/detail_cast/screen/detail_cast_screen.dart';

import '../../../../core/utils/text_manager.dart';

class ListCreditWidget extends StatelessWidget {
  final List<Credit> credit;
  const ListCreditWidget({super.key, required this.credit});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: (credit.isNotEmpty) ? credit.length - 1 : 0,
        itemBuilder: (context, index) {
          final item = credit[index];
          return GestureDetector(
            onTap: () {
              AppNavigator.push(context, DetailCastScreen(id: item.id!));
            },
            child: Padding(
              padding: EdgeInsets.all(PaddingSizes.p8),
              child: Container(
                width: 150.w, // Giảm chiều rộng
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(RadiusSizes.r16),
                  color: AppColors.containerWhite,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shawdowListView,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(RadiusSizes.r16),
                          child: item.profilePath != null
                              ? Image.network(
                                  AppImages.getImageUrl(item.profilePath!),
                                  height: 200.h,
                                  width: 150.w,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(AppImages.noImage,
                                  height: 200.h,
                                  width: 150.w,
                                  fit: BoxFit.cover),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(PaddingSizes.p8),
                          child: Text(
                            item.name ?? '',
                            maxLines: 2, // Giới hạn 2 dòng
                            overflow:
                                TextOverflow.ellipsis, // Hiển thị dấu "..."
                            style: TextManager.textStyleBlod(TextSizes.s16)
                                .copyWith(
                              color: AppColors.textBlack,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(PaddingSizes.p8),
                          child: Text(
                            item.character ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextManager.textStyleMedium(TextSizes.s16)
                                .copyWith(
                              color: AppColors.textGrey,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
