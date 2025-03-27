import 'package:flutter/material.dart';
import 'package:the_movie/core/comons/widgets/page_number.dart';
import 'package:the_movie/data/models/search/search_movie.dart';
import 'package:the_movie/presentation/detail_search/widget/movie_widget.dart';

import '../../../../data/models/medias/movie.dart';

class TabMovie extends StatefulWidget {
  final SearchMovie movieData;
  final Function(int) onPageChanged;

  const TabMovie(
      {super.key, required this.movieData, required this.onPageChanged});

  @override
  State<TabMovie> createState() => _TabMovieState();
}

class _TabMovieState extends State<TabMovie> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: widget.movieData.results.length,
              itemBuilder: (context, index) {
                Movie movie = widget.movieData.results[index];
                return MovieWidget(
                  title: movie.title,
                  releaseDate: movie.releaseDate,
                  overview: movie.overview,
                  posterPath: movie.posterPath,
                );
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.movieData.page > 1)
              IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: () {
                  widget.onPageChanged(widget.movieData.page - 1);
                },
              ),
            PageNumber(
              page: 1,
              isChoose: widget.movieData.page == 1,
              onPageChanged: (_) {
                widget.onPageChanged(1);
              },
            ),
            if (widget.movieData.page > 3) Text('...'),
            if (widget.movieData.page > 2)
              PageNumber(
                page: widget.movieData.page - 1,
                isChoose: false,
                onPageChanged: (_) {
                  widget.onPageChanged(widget.movieData.page - 1);
                },
              ),
            if (widget.movieData.page != 1 &&
                widget.movieData.page != widget.movieData.totalPages)
              PageNumber(
                page: widget.movieData.page,
                isChoose: true,
                onPageChanged: (_) {
                  widget.onPageChanged(widget.movieData.page);
                },
              ),
            if (widget.movieData.page < widget.movieData.totalPages - 1)
              PageNumber(
                page: widget.movieData.page + 1,
                isChoose: false,
                onPageChanged: (_) {
                  widget.onPageChanged(widget.movieData.page + 1);
                },
              ),
            if (widget.movieData.page < widget.movieData.totalPages - 2)
              Text('...'),
            PageNumber(
              page: widget.movieData.totalPages,
              isChoose: widget.movieData.page == widget.movieData.totalPages,
              onPageChanged: (_) {
                widget.onPageChanged(widget.movieData.totalPages);
              },
            ),
            if (widget.movieData.page < widget.movieData.totalPages)
              IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () {
                  widget.onPageChanged(widget.movieData.page + 1);
                },
              ),
          ],
        )
      ],
    );
  }
}