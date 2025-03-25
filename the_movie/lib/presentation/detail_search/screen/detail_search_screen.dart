import 'package:flutter/material.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_screen/tab_collection.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_screen/tab_company.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_screen/tab_data.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_screen/tab_keyword.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_screen/tab_movie.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_screen/tab_people.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_screen/tab_tv_show.dart';

import '../widget/search_bar_widget.dart';

class DetailSearchScreen extends StatefulWidget {
  const DetailSearchScreen({super.key});

  @override
  State<DetailSearchScreen> createState() => _DetailSearchScreenState();
}

class _DetailSearchScreenState extends State<DetailSearchScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late TabController tabController;
  List<TabData> screen = [];

  @override
  void initState() {
    // TODO: implement initState

    screen.addAll([
      TabData(
        'TV Shows',
        TabTvShow(
          query: '',
        ),
      ),
      TabData(
        'Movies',
        TabMovie(
          query: '',
        ),
      ),
      TabData(
        'People',
        TabPeople(
          query: '',
        ),
      ),
      TabData(
        'Collections',
        TabCollection(
          query: '',
        ),
      ),
      TabData(
        'Keywords',
        TabKeyword(
          query: '',
        ),
      ),
      TabData(
        'Companies',
        TabCompany(
          query: '',
        ),
      )
    ]);

    tabController = TabController(length: screen.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
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
            delegate: _SearchBarDelegate(),
          ),
          SliverAppBar(
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
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Search Results',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            bottom: TabBar(
              isScrollable: true,
              controller: tabController,
              tabs: screen
                  .map((e) => Tab(
                        text: e.title,
                      ))
                  .toList(),
            ),
          )
        ],
        body: TabBarView(
            controller: tabController,
            children: screen.map((e) => e.widget).toList()),
      )),
    );
  }
}

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 56;

  @override
  double get maxExtent => 56;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SearchBarWidget();
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
