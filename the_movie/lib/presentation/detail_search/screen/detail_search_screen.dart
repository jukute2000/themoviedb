import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_collection/screen/tab_collection.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_company/screen/tab_company.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_keyword/screen/tab_keyword.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_movie/screen/tab_movie.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_people/screen/tab_people.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_tv_show/screen/tab_tv_show.dart';

import '../../../core/comons/extension/search_category.dart';
import '../../../core/comons/widgets/keyword_container.dart';
import '../../../core/constants/strings_manager.dart';
import '../stream_controller/search_total_provider.dart';
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
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: NestedScrollView(
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
                    onPressed: () {},
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        StringsManager.search.tr(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(HeightSizes.h50),
                    child: StreamBuilder<Map<String, int>>(
                        stream:
                            SearchTotalProvider.of(context)?.totalResultsStream,
                        initialData:
                            SearchTotalProvider.of(context)?.totalResults,
                        builder: (context, snapshot) {
                          if (SearchTotalProvider.of(context) == null) {
                            return const Center(
                                child: Text(
                                    "Provider is missing. Please restart the app."));
                          }

                          if (!snapshot.hasData) {
                            return const Center(child: Text('No data'));
                          }
                          try {
                            final totalResults = snapshot.data ?? {};
                            return TabBar(
                              isScrollable: true,
                              controller: tabController,
                              tabs: SearchCategory.values.map((category) {
                                return buildTab(
                                  totalResults[category.name] ?? 0,
                                  category.localizedName,
                                );
                              }).toList(),
                            );
                          } catch (e) {
                            return const Center(
                                child: Text("Error loading data"));
                          }
                        }),
                  ),
                )
              ],
          body: TabBarView(
            controller: tabController,
            children: [
              TabTvShow(query: widget.query),
              TabMovieShow(query: widget.query),
              TabPeople(query: widget.query),
              TabCollection(query: widget.query),
              TabKeyword(query: widget.query),
              TabCompany(query: widget.query),
            ],
          )),
    ));
  }

  Tab buildTab(int? total, String title) {
    return Tab(
      child: Row(
        children: [
          Text(title),
          GapsManager.w10,
          total == null || total == 0
              ? const SizedBox()
              : KeywordContainer(
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
