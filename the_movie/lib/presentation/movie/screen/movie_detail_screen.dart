import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/presentation/home/widgets/appbar_widget.dart';
import 'package:the_movie/presentation/home/widgets/title_widget.dart';
import 'package:the_movie/presentation/movie/widget/key_word/key_word.dart';
import 'package:the_movie/presentation/movie/widget/media_detail/media_detail_widget.dart';
import 'package:the_movie/presentation/movie/widget/media_recommend/media_recommend_widget.dart';
import 'package:the_movie/presentation/movie/widget/serie_cast/serie_cast_widget.dart';

class MovieDetailScreen extends StatelessWidget {
  final int id;
  final bool isMovie;
  const MovieDetailScreen({super.key, required this.id, required this.isMovie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          MediaDetailWidget(id: id, isMovie: isMovie),
          TitleWidget(
            title: "Media Recommend",
            fontSize: 20.sp,
          ),
          MediaRecommendWidget(id: id, isMovie: isMovie),
          TitleWidget(
            title: "Serie Cast",
            fontSize: 20.sp,
          ),
          SerieCastWidget(id: id, isMovie: isMovie),
          TitleWidget(
            title: "KeyWord",
            fontSize: 20.sp,
          ),
          KeyWord(id: id, isMovie: isMovie),
        ],
      )),
    );
  }
}
