import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_collection/bloc/tab_collection_cubit.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_collection/bloc/tab_collection_state.dart';
import 'package:the_movie/presentation/detail_search/widget/tab_view_widget.dart';

import '../../../../../data/models/collection/collection.dart';
import '../../../stream_controller/search_total_provider.dart';
import '../../../widget/pagination_controller.dart';

class TabCollection extends StatefulWidget {
  final String query;

  const TabCollection({super.key, required this.query});

  @override
  State<TabCollection> createState() => _TabCollectionState();
}

class _TabCollectionState extends State<TabCollection>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TabCollectionCubit>().fetchCollections(widget.query, 1);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TabCollectionCubit, TabCollectionState>(
        builder: (context, state) {
      if (state is TabCollectionLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is TabCollectionLoaded) {
        SearchTotalProvider.of(context)
            ?.updateTotal("collections", state.collectionsData.totalResults);
        return state.collectionsData.collections != null
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: state.collectionsData.collections?.length,
                        itemBuilder: (context, index) {
                          Collection collection =
                              state.collectionsData.collections![index];
                          return TabViewWidget(
                            media: collection,
                          );
                        }),
                  ),
                  PaginationControls(
                    currentPage: state.page,
                    totalPages: state.collectionsData.totalPages ?? 1,
                    onPageChanged: (newPage) {
                      context
                          .read<TabCollectionCubit>()
                          .fetchCollections(widget.query, newPage);
                    },
                  ),
                ],
              )
            : const Center(child: Text("No data"));
      } else if (state is TabCollectionError) {
        return Center(child: Text(state.message));
      }
      return const Center(child: CircularProgressIndicator());
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
