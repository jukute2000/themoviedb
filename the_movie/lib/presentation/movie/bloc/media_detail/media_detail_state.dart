import 'package:the_movie/data/models/media_detail/detail_media/detail_movie.dart';
import 'package:the_movie/data/models/media_detail/detail_media/detail_tv.dart';

abstract class MediaDetailState {}

class MediaDetailInitial extends MediaDetailState {}

class MediaDetailIsLoading extends MediaDetailState {}

class MovieDetailLoaded extends MediaDetailState {
  final DetailMovie detailMovie;
  MovieDetailLoaded({required this.detailMovie});
}

class TvDetailLoaded extends MediaDetailState {
  final DetailTv detailTv;
  TvDetailLoaded({required this.detailTv});
}

class MediaDetailError extends MediaDetailState {
  final String message;
  MediaDetailError(this.message);
}
