import 'package:flutter/material.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';

import '../widget/search_bar_widget.dart';

class DetailSearchScreen extends StatefulWidget {
  const DetailSearchScreen({super.key});

  @override
  State<DetailSearchScreen> createState() => _DetailSearchScreenState();
}

class _DetailSearchScreenState extends State<DetailSearchScreen> {
  final ScrollController _scrollController =
      ScrollController();

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
                    SliverToBoxAdapter(
                      child: ElevatedButton(
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
                    ),
                  ],
              body: ListView.builder(
                itemCount: 50,
                itemBuilder: (context, index) => ListTile(
                  title: Text("Item $index"),
                ),
              )),
        ));
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


