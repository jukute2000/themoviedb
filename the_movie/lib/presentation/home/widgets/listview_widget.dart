import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/configs/assets/app_images.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/data/models/medias/media.dart';
import 'package:the_movie/data/models/medias/movie.dart';
import 'package:the_movie/data/models/medias/tv.dart';
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
              AppNavigator.push(
                  context,
                  MovieDetailScreen(
                      id: item.id ?? 0,
                      isMovie: (item is Movie) ? true : false));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 160, // Giảm chiều rộng
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
                            height: 240, // Tăng chiều dài
                            width: double.infinity, // width: height / 1.5
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          left: 8,
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
                    if (item is Movie)
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.title ?? '',
                              maxLines: 2, // Giới hạn 2 dòng
                              overflow:
                                  TextOverflow.ellipsis, // Hiển thị dấu "..."
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              item.releaseDate != null
                                  ? DateFormat('MMM dd, yyyy')
                                      .format(item.releaseDate!)
                                      .toString()
                                  : "Null day",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      )
                    else if (item is TiVi)
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.name ?? '',
                              maxLines: 2, // Giới hạn 2 dòng
                              overflow:
                                  TextOverflow.ellipsis, // Hiển thị dấu "..."
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              DateFormat('MMM dd, yyyy')
                                  .format(item.firstAirDate!)
                                  .toString(),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
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
