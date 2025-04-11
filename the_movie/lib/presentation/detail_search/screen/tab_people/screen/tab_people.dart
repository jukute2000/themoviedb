import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/presentation/detail_cast/screen/detail_cast_screen.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_people/bloc/tab_people_cubit.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_people/bloc/tab_people_state.dart';
import 'package:the_movie/presentation/detail_search/widget/people_widget.dart';

import '../../../../../core/comons/extension/search_category.dart';
import '../../../../../data/models/people/people.dart';
import '../../../stream_controller/search_total_provider.dart';
import '../../../widget/pagination_controller.dart';

class TabPeople extends StatefulWidget {
  final String query;
  final int totalResults;

  const TabPeople({super.key, required this.query, required this.totalResults});

  @override
  State<TabPeople> createState() => _TabPeopleState();
}

class _TabPeopleState extends State<TabPeople>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<TabPeopleCubit>().fetchPeople(widget.query, 1);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TabPeopleCubit, TabPeopleState>(
        builder: (context, state) {
      if (state is TabPeopleLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is TabPeopleLoaded) {
        final searchTotalProvider = SearchTotalProvider.of(context);
        if (searchTotalProvider != null) {
          searchTotalProvider.updateTotal(
            SearchCategory.people.name,
            state.peopleData.totalResults,
          );
        } else {
          debugPrint("⚠️ Warning: SearchTotalProvider không được tìm thấy!");
        }
        return state.peopleData.peoples != null
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: state.peopleData.peoples?.length,
                        itemBuilder: (context, index) {
                          People? people = state.peopleData.peoples?[index];
                          return GestureDetector(
                            onTap: () {
                              AppNavigator.push(
                                  context, DetailCastScreen(id: people!.id!));
                            },
                            child: PeopleWidget(
                              knownForDepartment: people?.knownForDepartment,
                              name: people?.name,
                              knownFor: people?.knowFors,
                              profilePath: people?.profilePath,
                            ),
                          );
                        }),
                  ),
                  PaginationControls(
                    currentPage: state.page,
                    totalPages: state.peopleData.totalPages ?? 1,
                    onPageChanged: (newPage) {
                      context
                          .read<TabPeopleCubit>()
                          .fetchPeople(widget.query, newPage);
                    },
                  ),
                ],
              )
            : const Center(child: Text("No data"));
      } else if (state is TabPeopleError) {
        return Center(child: Text(state.message));
      }
      return const Center(child: Text("No data"));
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
