import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/core/comons/extension/search_category.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/presentation/movie/screen/movie_detail_screen.dart';

import '../../../../../data/models/medias/tv.dart';
import '../../../stream_controller/search_total_provider.dart';
import '../../../widget/pagination_controller.dart';
import '../../../widget/tab_view_widget.dart';
import '../bloc/tab_tv_show_cubit.dart';
import '../bloc/tab_tv_show_state.dart';

class TabTvShow extends StatefulWidget {
  final String query;
  final int totalResults;

  const TabTvShow({super.key, required this.query, required this.totalResults});

  @override
  State<TabTvShow> createState() => _TabTvShowState();
}

class _TabTvShowState extends State<TabTvShow>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context
        .read<TabTvShowCubit>()
        .fetchTvShows(widget.query, 1); // Fetch khi tab được mở
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TabTvShowCubit, TabTvShowState>(
      builder: (context, state) {
        if (state is TabTvShowLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TabTvShowLoaded) {
          final searchTotalProvider = SearchTotalProvider.of(context);
          if (searchTotalProvider != null) {
            searchTotalProvider.updateTotal(
              SearchCategory.tv.name,
              state.tvData.totalResults,
            );
          } else {
            debugPrint("⚠️ Warning: SearchTotalProvider không được tìm thấy!");
          }
          return state.tvData.results != null
              ? Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.tvData.results?.length ?? 0,
                  itemBuilder: (context, index) {
                    TiVi tiVi = state.tvData.results![index];
                    return GestureDetector(
                      onTap: () {
                        AppNavigator.push(context,
                            MovieDetailScreen(id: tiVi.id!, isMovie: false));
                      },
                      child: TabViewWidget(
                        media: tiVi,
                      ),
                    );
                  },
                ),
              ),
              PaginationControls(
                currentPage: state.page,
                totalPages: state.tvData.totalPages ?? 1,
                onPageChanged: (newPage) {
                  context
                      .read<TabTvShowCubit>()
                      .fetchTvShows(widget.query, newPage);
                },
              ),
            ],
          )
              : const Center(child: Text("No data"));
        } else if (state is TabTvShowError) {
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
