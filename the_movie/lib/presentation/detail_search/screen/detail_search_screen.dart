import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/data/models/search/search_collections.dart';
import 'package:the_movie/data/models/search/search_movie.dart';
import 'package:the_movie/data/models/search/search_tv.dart';
import 'package:the_movie/presentation/detail_search/bloc/detail_search_state.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_screen/tab_collection.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_screen/tab_company.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_screen/tab_keyword.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_screen/tab_movie.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_screen/tab_people.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_screen/tab_tv_show.dart';

import '../../../core/comons/widgets/keyword_container.dart';
import '../../../core/constants/strings_manager.dart';
import '../../../data/models/search/search_companies.dart';
import '../../../data/models/search/search_keywords.dart';
import '../../../data/models/search/search_people.dart';
import '../bloc/detail_search_cubit.dart';
import '../widget/search_bar_widget.dart';

class DetailSearchScreen extends StatefulWidget {
  final String query;
  final int index;

  const DetailSearchScreen(
      {super.key, required this.query, required this.index});

  @override
  State<DetailSearchScreen> createState() => _DetailSearchScreenState();
}

class _DetailSearchScreenState extends State<DetailSearchScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late TextEditingController _controller;
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    tabController =
        TabController(length: 6, vsync: this, initialIndex: widget.index);
    _controller = TextEditingController();
    context.read<DetailSearchCubit>().fetchData(widget.query, 1);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onPageChangedMovie(int? page) {
    if (page != null && page > 0) {
      context.read<DetailSearchCubit>().fetchDataMovie(widget.query, page);
    }
  }

  void _onPageChangedPeople(int? page) {
    if (page != null && page > 0) {
      context.read<DetailSearchCubit>().fetchDataPeople(widget.query, page);
    }
  }

  void _onPageChangedTvShow(int? page) {
    if (page != null && page > 0) {
      context.read<DetailSearchCubit>().fetchDataTvShow(widget.query, page);
    }
  }
  void _onPageChangedCollection(int? page) {
    if (page != null && page > 0) {
      context.read<DetailSearchCubit>().fetchDataCollection(widget.query, page);
    }
  }
  void _onPageChangedKeyword(int? page) {
    if (page != null && page > 0) {
      context.read<DetailSearchCubit>().fetchDataKeyword(widget.query, page);
    }
  }
  void _onPageChangedCompany(int? page) {
    if (page != null && page > 0) {
      context.read<DetailSearchCubit>().fetchDataCompany(widget.query, page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: BlocBuilder<DetailSearchCubit, DetailSearchState>(
          builder: (context, state) {
        if (state is DetailSearchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DetailSearchError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is DetailSearchLoaded) {
          SearchTv searchTv = state.searchTv;
          SearchMovie searchMovie = state.movieData;
          SearchPeople searchPeople = state.peopleData;
          SearchCollections searchCollections = state.collectionsData;
          SearchKeywords searchKeywords = state.keywordsData;
          SearchCompanies searchCompanies = state.companiesData;
          return NestedScrollView(
              controller: _scrollController,
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      leading: const Icon(Icons.menu),
                      title: const Center(child: Text("Detail Search")),
                      actions: [
                        const Icon(Icons.person),
                        GapsManager.w10,
                        const Icon(Icons.search)
                      ],
                      floating: true,
                      pinned: false,
                      snap: true,
                    ),
                    SliverPersistentHeader(
                      floating: false,
                      pinned: true,
                      delegate: _SearchBarDelegate(controller: _controller),
                    ),
                    SliverAppBar(
                      titleSpacing: 0,
                      pinned: false,
                      floating: true,
                      snap: true,
                      title: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        onPressed: () {
                          context
                              .read<DetailSearchCubit>()
                              .fetchData(_controller.text, 1);
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            StringsManager.search.tr(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      bottom: TabBar(
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        controller: tabController,
                        onTap: (index) {
                          final currentPage = (context
                                      .read<DetailSearchCubit>()
                                      .state as DetailSearchLoaded)
                                  .currentPages[index] ??
                              1;

                          switch (index) {
                            case 0:
                              context
                                  .read<DetailSearchCubit>()
                                  .fetchDataTvShow(widget.query, currentPage);
                              break;
                            case 1:
                              context
                                  .read<DetailSearchCubit>()
                                  .fetchDataMovie(widget.query, currentPage);
                              break;
                            case 2:
                              context
                                  .read<DetailSearchCubit>()
                                  .fetchDataPeople(widget.query, currentPage);
                              break;
                            default:
                              break;
                          }
                        },
                        tabs: [
                          buildTab(searchTv.totalResults, StringsManager.tvShows.tr()),
                          buildTab(searchMovie.totalResults, StringsManager.movies.tr()),
                          buildTab(searchPeople.totalResults, StringsManager.people.tr()),
                          buildTab(searchCollections.totalResults, StringsManager.collections.tr()),
                          buildTab(searchKeywords.totalResults, StringsManager.keywords.tr()),
                          buildTab(searchCompanies.totalResults, StringsManager.companies.tr()),
                        ],
                      ),
                    )
                  ],
              body: TabBarView(
                controller: tabController,
                children: [
                  TabTvShow(
                      tvData: state.searchTv,
                      onPageChanged: _onPageChangedTvShow),
                  TabMovie(
                      movieData: state.movieData,
                      onPageChanged: _onPageChangedMovie),
                  TabPeople(
                      peopleData: state.peopleData,
                      onPageChanged: _onPageChangedPeople),
                  TabCollection(
                      collectionData: state.collectionsData,
                      onPageChanged: _onPageChangedCollection),
                  TabKeyword(
                      keywordData: state.keywordsData,
                      onPageChanged: _onPageChangedKeyword),
                  TabCompany(
                      companyData: state.companiesData,
                      onPageChanged: _onPageChangedCompany),
                ],
              ));
        } else {
          return const Center(child: Text('Error'));
        }
      })),
    );
  }

  Tab buildTab(int? total, String title) {
    return Tab(
      child: Row(
        children: [
          Text(title),
          GapsManager.w10,
          KeywordContainer(
            keyword: total.toString(),
            isSelected: widget.index == 0,
          ),
        ],
      ),
    );
  }
}

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final TextEditingController controller;

  _SearchBarDelegate({required this.controller});

  @override
  double get minExtent => 56;

  @override
  double get maxExtent => 56;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SearchBarWidget(
      controller: controller,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
