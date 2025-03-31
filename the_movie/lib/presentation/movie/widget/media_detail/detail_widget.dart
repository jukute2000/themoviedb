import 'package:flutter/material.dart';
import 'package:the_movie/data/models/media_detail/detail_media/detail_meida.dart';
import 'package:the_movie/presentation/movie/widget/media_detail/crew_section_widget.dart';
import 'package:the_movie/presentation/movie/widget/media_detail/header_section_widget.dart';
import 'package:the_movie/presentation/movie/widget/media_detail/info_section_widget.dart';
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
          color: const Color.fromARGB(240, 0, 20, 0),
          child: Column(
            children: [
              HeaderSection(
                backdropPath: detailMedia.backdropPath ?? '',
                posterPath: detailMedia.posterPath ?? '',
              ),
              TitleSection(
                  releaseDate: detailMedia.releaseDayMedia,
                  title: detailMedia.titleName),
              RatingSection(voteAverage: detailMedia.voteAverage ?? 0),
              const CustomDivider(),
              InfoSection(
                  releaseDateText: detailMedia.releaseDateText,
                  originText: detailMedia.originText,
                  runtimeText: detailMedia.runtimeText,
                  genreText: detailMedia.genreText),
              const CustomDivider(),
              OverviewSection(
                  tagline: detailMedia.tagline ?? '',
                  overview: detailMedia.overview ?? ''),
              const CrewSection(),
              const SizedBox(height: 20),
            ],
          ),
        )
      ],
    );
  }
}
