import 'package:flutter/material.dart';
import 'package:the_movie/presentation/widgets/appbar_widget.dart';
import 'package:the_movie/presentation/detail_cast/widget/detail_cast.dart';

class DetailCastScreen extends StatefulWidget {
  final int id;
  const DetailCastScreen({super.key, required this.id});

  @override
  State<DetailCastScreen> createState() => _DetailCastScreenState();
}

class _DetailCastScreenState extends State<DetailCastScreen> {
  late ScrollController scrollController;
  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppbarWidget(
        scrollController: scrollController,
        body: DetailCast(id: widget.id),
        isHome: false,
      ),
    );
  }
}
