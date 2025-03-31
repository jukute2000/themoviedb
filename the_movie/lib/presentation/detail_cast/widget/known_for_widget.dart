import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/assets/app_images.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/data/models/medias/movie.dart';

import '../../../core/configs/navigation/app_navigation.dart';
import '../../movie/screen/movie_detail_screen.dart';

class KnownForWidget extends StatelessWidget {
  const KnownForWidget({super.key, required this.movies});
  final List<Movie> movies;
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return Padding(
      padding: EdgeInsets.all(PaddingSizes.p32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Known For",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 285.h,
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: movies.length < 8 ? movies.length : 8,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  Movie movie = movies[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          AppNavigator.push(
                              context,
                              MovieDetailScreen(
                                id: movie.id ?? 0,
                                isMovie: true,
                              ));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 150.w,
                              height: 220.h,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: movie.posterPath != null
                                      ? NetworkImage(
                                          AppImages.getImageUrlCast(
                                            movie.posterPath!,
                                          ),
                                        )
                                      : const AssetImage(AppImages.noImage),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            SizedBox(
                              width: 150.w,
                              child: Text(
                                movie.title ?? "Unknow",
                                maxLines: 2,
                                softWrap: true,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                      GapsManager.w10,
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
