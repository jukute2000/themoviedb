import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/movie/bloc/media_detail/media_detail_cubit.dart';
import 'package:the_movie/presentation/movie/bloc/media_detail/media_detail_state.dart';
import 'package:the_movie/presentation/movie/widget/media_detail/crew_section_widget.dart';
import 'package:the_movie/presentation/movie/widget/media_detail/header_section_widget.dart';
import 'package:the_movie/presentation/movie/widget/media_detail/info_section_widget.dart';
import 'package:the_movie/presentation/movie/widget/media_detail/movie_detail_nav_bar.dart';
import 'package:the_movie/presentation/movie/widget/media_detail/overview_section_widget.dart';
import 'package:the_movie/presentation/movie/widget/media_detail/rating_section_widget.dart';
import 'package:the_movie/presentation/movie/widget/media_detail/title_section_widget.dart';

class MediaDetailWidget extends StatelessWidget {
  final int id;
  final bool isMovie;

  const MediaDetailWidget({super.key, required this.id, required this.isMovie});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MediaDetailCubit()..loadMedia(id, isMovie),
      child: BlocBuilder<MediaDetailCubit, MediaDetailState>(
          builder: (context, state) {
        if (state is MediaDetailIsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MediaDetailError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is MovieDetailLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MovieDetailNavBar(),
              Container(
                color: const Color.fromARGB(240, 0, 20, 0),
                child: Column(
                  children: [
                    HeaderSection(
                      backdropPath: state.detailMovie.backdropPath!,
                      posterPath: state.detailMovie.posterPath!,
                    ),
                    TitleSection(
                        releaseDate: state.detailMovie.releaseDate!,
                        title: state.detailMovie.title),
                    RatingSection(voteAverage: state.detailMovie.voteAverage),
                    const CustomDivider(),
                    InfoSection(
                        releaseDateText: state.detailMovie.releaseDateText,
                        originText: state.detailMovie.originText,
                        runtimeText: state.detailMovie.runtimeText,
                        genreText: state.detailMovie.genreText),
                    const CustomDivider(),
                    OverviewSection(
                        tagline: state.detailMovie.tagline!,
                        overview: state.detailMovie.overview!),
                    const CrewSection(),
                    const SizedBox(height: 20),
                  ],
                ),
              )
            ],
          );
        } else if (state is TvDetailLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MovieDetailNavBar(),
              Container(
                color: const Color.fromARGB(240, 0, 20, 0),
                child: Column(
                  children: [
                    HeaderSection(
                        backdropPath: state.detailTv.backdropPath!,
                        posterPath: state.detailTv.posterPath!),
                    TitleSection(
                        releaseDate: state.detailTv.firstAirDate!,
                        title: state.detailTv.name!),
                    RatingSection(voteAverage: state.detailTv.voteAverage!),
                    const CustomDivider(),
                    InfoSection(
                        releaseDateText: state.detailTv.releaseDateText,
                        originText: state.detailTv.originText,
                        runtimeText: state.detailTv.runtimeText,
                        genreText: state.detailTv.genreText),
                    const CustomDivider(),
                    OverviewSection(
                        tagline: state.detailTv.tagline!,
                        overview: state.detailTv.overview!),
                    const CrewSection(),
                    const SizedBox(height: 20),
                  ],
                ),
              )
            ],
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Colors.black,
      thickness: 2,
      height: 20,
    );
  }
}
