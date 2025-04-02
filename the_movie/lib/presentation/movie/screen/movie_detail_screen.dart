import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/presentation/home/widgets/appbar_widget.dart';
import 'package:the_movie/presentation/home/widgets/title_widget.dart';
import 'package:the_movie/presentation/movie/widget/key_word/key_word.dart';
import 'package:the_movie/presentation/movie/widget/media_detail/media_detail_widget.dart';
import 'package:the_movie/presentation/movie/widget/media_recommend/media_recommend_widget.dart';
import 'package:the_movie/presentation/movie/widget/serie_cast/serie_cast_widget.dart';
import 'package:the_movie/presentation/widgets/appbar_widget.dart';

import '../../../core/configs/assets/app_strings.dart';

class MovieDetailScreen extends StatefulWidget {
  final int id;
  final bool isMovie;
  const MovieDetailScreen({super.key, required this.id, required this.isMovie});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
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
      body: AppbarWidget(
        scrollController: _scrollController,
        isHome: false,
        body: SingleChildScrollView(
            child: Column(
          children: [
            MediaDetailWidget(id: widget.id, isMovie: widget.isMovie),
            TitleWidget(
              title: AppStrings.mediaRecommend.tr(),
              fontSize: 20.sp,
            ),
            MediaRecommendWidget(id: widget.id, isMovie: widget.isMovie),
            TitleWidget(
              title: AppStrings.serieCast.tr(),
              fontSize: 20.sp,
            ),
            SerieCastWidget(id: widget.id, isMovie: widget.isMovie),
            TitleWidget(
              title: AppStrings.keyword.tr(),
              fontSize: 20.sp,
            ),
            KeyWord(id: widget.id, isMovie: widget.isMovie),
          ],
        )),
      ),
    );
  }
}
