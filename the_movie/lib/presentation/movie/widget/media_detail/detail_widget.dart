import 'package:flutter/material.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/data/models/media_detail/detail_media/detail_meida.dart';
import 'package:the_movie/presentation/movie/widget/media_detail/crew_section_widget.dart';
import 'package:the_movie/presentation/movie/widget/media_detail/header_section_widget.dart';
import 'package:the_movie/presentation/movie/widget/infor_icon/info_section_widget.dart';
import 'package:the_movie/presentation/movie/widget/media_detail/media_detail_widget.dart';
import 'package:the_movie/presentation/movie/widget/media_detail/movie_detail_nav_bar.dart';
import 'package:the_movie/presentation/movie/widget/media_detail/overview_section_widget.dart';
import 'package:the_movie/presentation/movie/widget/rating/rating_section_widget.dart';
import 'package:the_movie/presentation/movie/widget/media_detail/title_section_widget.dart';

class DetailWidget extends StatelessWidget {
  final DetailMedia detailMedia;
  const DetailWidget({super.key, required this.detailMedia});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MovieDetailNavBar(),
        Container(
          color: AppColors.containerNavBar,
          child: Column(
            children: [
              HeaderSection(
                backdropPath: detailMedia.backdropPath ?? '',
                posterPath: detailMedia.posterPath ?? '',
              ),
              TitleSection(
                  releaseDate: detailMedia.releaseDayMedia,
                  title: detailMedia.titleName),
              RatingSection(
                voteAverage: detailMedia.voteAverage ?? 0,
                isMovie: detailMedia.isMovie(),
              ),
              const CustomDivider(),
              InfoSection(
                  isMovie: detailMedia.isMovie(),
                  releaseDateText: detailMedia.releaseDateText,
                  originText: detailMedia.originText,
                  runtimeText: detailMedia.runtimeText,
                  genreText: detailMedia.genreText),
              const CustomDivider(),
              OverviewSection(
                  tagline: detailMedia.tagline ?? '',
                  overview: detailMedia.overview ?? ''),
              const CrewSection(),
              GapsManager.h20
            ],
          ),
        )
      ],
    );
  }
}
