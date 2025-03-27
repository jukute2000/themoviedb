import 'package:the_movie/data/models/keyword/keyword.dart';
import 'package:the_movie/data/models/media_detail/detail_media/detail_movie.dart';
import 'package:the_movie/data/models/media_detail/detail_media/detail_tv.dart';
import 'package:the_movie/data/models/medias/movie.dart';
import 'package:the_movie/data/models/medias/tv.dart';

import '../../data/models/credits/credit.dart';
import '../../data/models/video/video.dart';

abstract class DemoDetailStateCubit {}

class Initial extends DemoDetailStateCubit {}

class IsLoading extends DemoDetailStateCubit {}

class TvDetail extends DemoDetailStateCubit {
  final DetailTv tv;
  final List<TiVi> tvRe;
  final List<Credit> credits;
  final List<Keyword> keywords;
  final List<Video> videos;
  TvDetail(
      {required this.tv,
      required this.tvRe,
      required this.credits,
      required this.keywords,
      required this.videos});
}

class MovieDetail extends DemoDetailStateCubit {
  final DetailMovie movie;
  final List<Movie> mvRe;
  final List<Credit> credits;
  final List<Keyword> keywords;
  final List<Video> videos;
  MovieDetail(
      {required this.movie,
      required this.mvRe,
      required this.credits,
      required this.keywords,
      required this.videos});
}

class Error extends DemoDetailStateCubit {
  final String message;
  Error(this.message);
}
