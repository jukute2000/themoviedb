import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/core/comons/extension/search_category.dart';
import 'package:the_movie/data/models/medias/movie.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_movie/bloc/tab_movie_cubit.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_movie/bloc/tab_movie_state.dart';

import '../../../../../core/configs/navigation/app_navigation.dart';
import '../../../../movie/screen/movie_detail_screen.dart';
import '../../../stream_controller/search_total_provider.dart';
import '../../../widget/pagination_controller.dart';
import '../../../widget/tab_view_widget.dart';

class TabMovieShow extends StatefulWidget {
  final String query;
  final int totalResults;
  const TabMovieShow({super.key, required this.query, required this.totalResults});

  @override
  State<TabMovieShow> createState() => _TabMovieShowState();
}

class _TabMovieShowState extends State<TabMovieShow>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context
        .read<TabMovieCubit>()
        .fetchMovieData(widget.query, 1); // Fetch khi tab được mở
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TabMovieCubit, TabMovieState>(
      builder: (context, state) {
        if (state is TabMovieLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TabMovieLoaded) {
          final searchTotalProvider = SearchTotalProvider.of(context);
          if (searchTotalProvider != null) {
            searchTotalProvider.updateTotal(
              SearchCategory.movie.name,
              state.movieData.totalResults,
            );
          } else {
            debugPrint("⚠️ Warning: SearchTotalProvider không được tìm thấy!");
          }
          return state.movieData.results != null
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.movieData.results?.length ?? 0,
                        itemBuilder: (context, index) {
                          Movie movie = state.movieData.results![index];
                          return GestureDetector(
                            onTap: () {
                              AppNavigator.push(
                                context,
                                MovieDetailScreen(
                                  id: movie.id!,
                                  isMovie: true,
                                ),
                              );
                            },
                            child: TabViewWidget(
                              media: movie,
                            ),
                          );
                        },
                      ),
                    ),
                    PaginationControls(
                      currentPage: state.page,
                      totalPages: state.movieData.totalPages ?? 1,
                      onPageChanged: (newPage) {
                        context
                            .read<TabMovieCubit>()
                            .fetchMovieData(widget.query, newPage);
                      },
                    ),
                  ],
                )
              : const Center(child: Text("No data"));
        } else if (state is TabMovieError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text("No data"));
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
