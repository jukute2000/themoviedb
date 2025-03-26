
import 'package:flutter/material.dart';
import 'package:the_movie/data/models/media_detail/detail_movie.dart';
import 'package:the_movie/presentation/movie/widget/crew_section_widget.dart';
import 'package:the_movie/presentation/movie/widget/header_section_widget.dart';
import 'package:the_movie/presentation/movie/widget/info_section_widget.dart';
import 'package:the_movie/presentation/movie/widget/movie_detail_nav_bar.dart';
import 'package:the_movie/presentation/movie/widget/overview_section_widget.dart';
import 'package:the_movie/presentation/movie/widget/rating_section_widget.dart';
import 'package:the_movie/presentation/movie/widget/title_section_widget.dart';

class DetailMovieScreen extends StatelessWidget {
  final DetailMovie movie;

  const DetailMovieScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MovieDetailNavBar(),
            Container(
              color: const Color.fromARGB(240, 0, 20, 0),
              child: Column(
                children: [
                  HeaderSection(movie: movie),
                  TitleSection(movie: movie),
                  RatingSection(voteAverage: movie.voteAverage),
                  const CustomDivider(),
                  InfoSection(movie: movie),
                  const CustomDivider(),
                  OverviewSection(movie: movie),
                  const CrewSection(),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
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
