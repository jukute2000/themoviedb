import 'package:flutter/material.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_collection/screen/tab_collection.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_company/screen/tab_company.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_keyword/screen/tab_keyword.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_movie/screen/tab_movie.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_people/screen/tab_people.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_tv_show/screen/tab_tv_show.dart';
import 'package:the_movie/presentation/home/widgets/drawer_widget.dart';
import 'package:the_movie/presentation/widgets/appbar_widget.dart';

import '../../../core/comons/extension/search_category.dart';
import '../../../initial/remote_confic.dart';
import '../stream_controller/search_total_provider.dart';

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
    _controller = TextEditingController(text: widget.query);
    checkRemoteConflict();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }


  Future<void> checkRemoteConflict() async {
    if (await RemoteConfic.instance.getSearch()) {
      showDialogSearch();
    }
  }

  void showDialogSearch() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Check"),
          content:
          const Text("Hello bạn đến với trang tìm kiếm"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      body: SafeArea(
          child: AppbarWidget(
              scrollController: _scrollController,
              tabController: tabController,
              controller: _controller,
              body: StreamBuilder<Map<String, int>>(
                  initialData: SearchTotalProvider.of(context)?.totalResults,
                  stream: SearchTotalProvider.of(context)?.totalResultsStream,
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
                      return TabBarView(
                        controller: tabController,
                        children: [
                          TabTvShow(
                              query: widget.query,
                              totalResults:
                                  totalResults[SearchCategory.tv.name] ?? 0),
                          TabMovieShow(
                              query: widget.query,
                              totalResults:
                                  totalResults[SearchCategory.movie.name] ?? 0),
                          TabPeople(
                              query: widget.query,
                              totalResults:
                                  totalResults[SearchCategory.people.name] ??
                                      0),
                          TabCollection(
                              query: widget.query,
                              totalResults: totalResults[
                                      SearchCategory.collections.name] ??
                                  0),
                          TabKeyword(
                              query: widget.query,
                              totalResults:
                                  totalResults[SearchCategory.keywords.name] ??
                                      0),
                          TabCompany(
                              query: widget.query,
                              totalResults:
                                  totalResults[SearchCategory.companies.name] ??
                                      0),
                        ],
                      );
                    } catch (e) {
                      return const Center(child: Text("Error loading data"));
                    }
                  }),
              isHome: true,
              isSearch: true)),
    );
  }
}
