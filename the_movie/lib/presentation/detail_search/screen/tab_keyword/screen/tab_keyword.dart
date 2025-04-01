import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/data/models/keyword/keyword.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_keyword/bloc/tab_keyword_state.dart';
import 'package:the_movie/presentation/detail_search/widget/keyword_widget.dart';

import '../../../stream_controller/search_total_provider.dart';
import '../../../widget/pagination_controller.dart';
import '../bloc/tab_keyword_cubit.dart';

class TabKeyword extends StatefulWidget {
  final String query;

  const TabKeyword({
    super.key,
    required this.query,
  });

  @override
  State<TabKeyword> createState() => _TabKeywordState();
}

class _TabKeywordState extends State<TabKeyword>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TabKeywordCubit>().fetchKeywords(widget.query, 1);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TabKeywordCubit, TabKeywordState>(
        builder: (context, state) {
      if (state is TabKeywordLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is TabKeywordLoaded) {
        SearchTotalProvider.of(context)
            ?.updateTotal("keywords", state.keywordsData.totalResults);
        return state.keywordsData.keywords != null ?
        Padding(
          padding: EdgeInsets.all(PaddingSizes.p24),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: state.keywordsData.keywords?.length,
                    itemBuilder: (context, index) {
                      Keyword? keyword = state.keywordsData.keywords?[index];
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: PaddingSizes.p8),
                        child: KeywordWidget(
                          keyword: keyword?.name ?? '',
                        ),
                      );
                    }),
              ),
              PaginationControls(
                currentPage: state.page,
                totalPages: state.keywordsData.totalPages ?? 1,
                onPageChanged: (newPage) {
                  context
                      .read<TabKeywordCubit>()
                      .fetchKeywords(widget.query, newPage);
                },
              ),
            ],
          ),
        ): const Center(child: Text("No data"));
      } else if (state is TabKeywordError) {
        return Center(child: Text(state.message));
      }
      return const Center(child: CircularProgressIndicator());
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
