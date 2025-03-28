import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/models/medias/movie.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_collection/bloc/tab_collection_state.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_movie/bloc/tab_movie_cubit.dart';

import '../../../stream_controller/search_total_provider.dart';
import '../../../widget/pagination_controller.dart';
import '../../../widget/tab_view_widget.dart';

class TabMovieShow extends StatefulWidget {
  final String query;

  const TabMovieShow({super.key, required this.query});

  @override
  State<TabMovieShow> createState() => _TabMovieShowState();
}

class _TabMovieShowState extends State<TabMovieShow> {
  @override
  void initState() {
    super.initState();
    context
        .read<MovieSearchCubit>()
        .fetchMovieData(widget.query, 1); // Fetch khi tab được mở
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MovieSearchCubit, MovieSearchState>(
      listener: (context, state) {
        if (state is MovieSearchLoaded) {
          print("🔥 Updating totalResults[movie]: ${state.movieData.totalResults}");

          SearchTotalProvider.of(context)
              ?.updateTotal("movie", state.movieData.totalResults);
        }
      },
      child: BlocBuilder<MovieSearchCubit, MovieSearchState>(
        builder: (context, state) {
          if (state is MovieSearchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieSearchLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.movieData.results?.length ?? 0,
                    itemBuilder: (context, index) {
                      Movie movie = state.movieData.results![index];
                      return TabViewWidget(
                        media: movie,
                      );
                    },
                  ),
                ),
                PaginationControls(
                  currentPage: state.page,
                  totalPages: state.movieData.totalPages ?? 1,
                  onPageChanged: (newPage) {
                    context.read<MovieSearchCubit>().fetchMovieData(widget.query, newPage);
                  },
                ),
              ],
            );
          } else if (state is MovieSearchError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
