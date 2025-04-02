import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/configs/assets/app_images.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/data/models/medias/media.dart';
import 'package:the_movie/presentation/movie/screen/movie_detail_screen.dart';

class ListviewWidget extends StatelessWidget {
  final List<Media> medias;
  const ListviewWidget({super.key, required this.medias});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
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
                width: 200.w, // Giảm chiều rộng
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
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
                            child: Image.network(
                              AppImages.getImageUrl(item.posterPath ?? ''),
                              height: 270.h, // Tăng chiều dài
                              width: double.infinity, // width: height / 1.5
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 8.w,
                            left: 8.w,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: item.goodMedia()
                                    ? Colors.green
                                    : Colors.amber[700],
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
                              item.getTitle(),
                              maxLines: 1, // Giới hạn 2 dòng
                              overflow:
                                  TextOverflow.ellipsis, // Hiển thị dấu "..."
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
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
                                  : "Null day",
                              style: TextStyle(
                                color: Colors.grey,
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
