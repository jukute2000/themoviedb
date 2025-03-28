import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/models/medias/tv.dart';
import '../../../stream_controller/search_total_provider.dart';
import '../../../widget/pagination_controller.dart';
import '../../../widget/tab_view_widget.dart';
import '../bloc/tab_tv_show_cubit.dart';
import '../bloc/tab_tv_show_state.dart';

class TabTvShow extends StatefulWidget {
  final String query;

  const TabTvShow({super.key, required this.query});

  @override
  State<TabTvShow> createState() => _TabTvShowState();
}

class _TabTvShowState extends State<TabTvShow> {
  @override
  void initState() {
    super.initState();
    context
        .read<TvSearchCubit>()
        .fetchTvShows(widget.query, 1); // Fetch khi tab được mở
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TvSearchCubit, TvSearchState>(
      listener: (context, state) {
        if (state is TvSearchLoaded) {
          // Cập nhật tổng số kết quả vào SearchTotalProvider hoặc thực hiện hành động khác
          SearchTotalProvider.of(context)
              ?.updateTotal("tv", state.tvData.totalResults);
        }
      },
      child: BlocBuilder<TvSearchCubit, TvSearchState>(
        builder: (context, state) {
          if (state is TvSearchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TvSearchLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.tvData.results?.length ?? 0,
                    itemBuilder: (context, index) {
                      TiVi tiVi = state.tvData.results![index];
                      return TabViewWidget(
                        media: tiVi,
                      );
                    },
                  ),
                ),
                PaginationControls(
                  currentPage: state.page,
                  totalPages: state.tvData.totalPages ?? 1,
                  onPageChanged: (newPage) {
                    context.read<TvSearchCubit>().fetchTvShows(widget.query, newPage);
                  },
                ),
              ],
            );
          } else if (state is TvSearchError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
