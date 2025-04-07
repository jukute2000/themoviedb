import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/configs/assets/app_images.dart';
import 'package:the_movie/core/configs/assets/app_strings.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/data/models/media_detail/detail_media/detail_meida.dart';
import 'package:the_movie/presentation/movie/screen/movie_detail_screen.dart';

class ListviewDetailWidget extends StatelessWidget {
  final List<DetailMedia> detailMedia;
  const ListviewDetailWidget({super.key, required this.detailMedia});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: (detailMedia.isNotEmpty) ? detailMedia.length - 1 : 0,
        itemBuilder: (context, index) {
          final item = detailMedia[index];
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
                width: 150.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
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
                            borderRadius: BorderRadius.circular(16),
                            child: item.posterPath != null
                                ? Image.network(
                                    AppImages.getImageUrl(item.posterPath!),
                                    height: 225.h,
                                    width: 155.w,
                                    fit: BoxFit.contain,
                                  )
                                : Image.asset(
                                    AppImages.noImage,
                                    height: 225.h,
                                    width: 155.w,
                                    fit: BoxFit.contain,
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
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                item.roundVoteAverage(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
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
                              item.titleName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(PaddingSizes.p8),
                            child: Text(
                              item.releaseDayMedia != null
                                  ? DateFormat('MMM dd, yyyy')
                                      .format(item.releaseDayMedia)
                                      .toString()
                                  : AppStrings.noInfomation.tr(),
                              style: TextStyle(
                                color: AppColors.textDay,
                                fontSize: 14.sp,
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
