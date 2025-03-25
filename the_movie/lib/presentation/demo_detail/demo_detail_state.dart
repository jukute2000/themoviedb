import 'package:the_movie/data/models/keywords/keywords.dart';
import 'package:the_movie/data/models/media_detail/detail_movie.dart';
import 'package:the_movie/data/models/media_detail/detail_tv.dart';
import 'package:the_movie/data/models/medias/movie.dart';
import 'package:the_movie/data/models/medias/tv.dart';

import '../../data/models/credits/credit.dart';

abstract class DemoDetailStateCubit {}

class Initial extends DemoDetailStateCubit {}

class IsLoading extends DemoDetailStateCubit {}

class TvDetail extends DemoDetailStateCubit {
  final DetailTv tv;
  final List<TiVi> tvRe;
  final List<Credit> credits;
  final List<Keywords> keywords;
  TvDetail(
      {required this.tv,
      required this.tvRe,
      required this.credits,
      required this.keywords});
}

class MovieDetail extends DemoDetailStateCubit {
  final DetailMovie movie;
  final List<Movie> mvRe;
  final List<Credit> credits;
  final List<Keywords> keywords;
  MovieDetail(
      {required this.movie,
      required this.mvRe,
      required this.credits,
      required this.keywords});
}

class Error extends DemoDetailStateCubit {
  final String message;
  Error(this.message);
}
