import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/assets/app_images.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/core/utils/text_manager.dart';
import 'package:the_movie/data/models/medias/movie.dart';
import 'package:the_movie/presentation/theme/screen/app_style_provider.dart';

import '../../../core/configs/assets/app_strings.dart';
import '../../../core/configs/navigation/app_navigation.dart';
import '../../movie/screen/movie_detail_screen.dart';

class KnownForWidget extends StatefulWidget {
  const KnownForWidget({super.key, required this.movies});
  final List<Movie>? movies;

  @override
  State<KnownForWidget> createState() => _KnownForWidgetState();
}

class _KnownForWidgetState extends State<KnownForWidget> {
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(PaddingSizes.p32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppStrings.knownFor.tr(),
            style: TextManager.textStyleBlod(TextSizes.s20),
          ),
          widget.movies == null
              ? Center(
                  child: Text(AppStrings.noInfomation.tr()),
                )
              : SizedBox(
                  height: 285.h,
                  child: Scrollbar(
                    controller: _scrollController,
                    thumbVisibility: true,
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount:
                          widget.movies!.length < 8 ? widget.movies!.length : 8,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        Movie movie = widget.movies![index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () {
                                if (movie.id != null) {
                                  AppNavigator.push(
                                      context,
                                      MovieDetailScreen(
                                        id: movie.id!,
                                        isMovie: true,
                                      ));
                                }
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
                                            : const AssetImage(
                                                AppImages.noImage),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        RadiusSizes.r8,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150.w,
                                    child: Text(
                                      movie.title ??
                                          AppStrings.noInfomation.tr(),
                                      maxLines: 2,
                                      softWrap: true,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextManager.textStyleRegular(
                                              TextSizes.s16)
                                          .copyWith(
                                        color: AppStyleProvider.of(context)
                                            .textColor(),
                                      ),
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
