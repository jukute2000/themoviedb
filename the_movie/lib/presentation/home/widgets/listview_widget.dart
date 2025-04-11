import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/configs/assets/app_images.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/core/utils/text_manager.dart';
import 'package:the_movie/data/models/medias/media.dart';
import 'package:the_movie/presentation/movie/screen/movie_detail_screen.dart';

import '../../../core/configs/assets/app_strings.dart';

class ListviewWidget extends StatelessWidget {
  final List<Media> medias;
  const ListviewWidget({super.key, required this.medias});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: (medias.isNotEmpty) ? medias.length - 1 : 0,
        itemBuilder: (context, index) {
          final item = medias[index];
          return GestureDetector(
            onTap: () {
              if (item.id != -1) {
                AppNavigator.push(
                  context,
                  MovieDetailScreen(
                    id: item.id!,
                    isMovie: item.isMovie(),
                  ),
                );
              }
            },
            child: Padding(
              padding: EdgeInsets.all(PaddingSizes.p8),
              child: Container(
                width: 155.w,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(RadiusSizes.r16),
                            child: item.posterPath != null
                                ? Image.network(
                                    AppImages.getImageUrl(item.posterPath!),
                                    height: 225.h,
                                    width: 155.w,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    AppImages.noImage,
                                    height: 225.h,
                                    width: 155.w,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Positioned(
                            bottom: 8.h,
                            left: 8.w,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 4.w),
                              decoration: BoxDecoration(
                                color: item.goodMedia()
                                    ? AppColors.goodVoteItem
                                    : AppColors.badVoteItem,
                                borderRadius:
                                    BorderRadius.circular(RadiusSizes.r16),
                              ),
                              child: Text(
                                item.roundVoteAverage(),
                                style:
                                    TextManager.textStyleRegular(TextSizes.s16)
                                        .copyWith(
                                  color: AppColors.textWhite,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(PaddingSizes.p8),
                            child: Text(
                              item.getTitle(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextManager.textStyleBlod(TextSizes.s16)
                                  .copyWith(
                                color: AppColors.textBlack,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(PaddingSizes.p8),
                            child: Text(
                              item.getReleaseDate() != null
                                  ? DateFormat('MMM dd, yyyy')
                                      .format(item.getReleaseDate()!)
                                      .toString()
                                  : AppStrings.noInfomation.tr(),
                              style: TextManager.textStyleRegular(TextSizes.s16)
                                  .copyWith(
                                color: AppColors.textDay,
                              ),
                            ),
                          ),
                        ],
                      )
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
