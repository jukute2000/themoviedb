import 'package:the_movie/data/models/medias/movie.dart';
import 'package:the_movie/data/models/medias/tv.dart';

abstract class MediaRecommendState {}

class MediaRecommendInitial extends MediaRecommendState {}

class MediaRecommendIsLoading extends MediaRecommendState {}

class MovieRecommendLoaded extends MediaRecommendState {
  final List<Movie> listMovie;
  MovieRecommendLoaded({required this.listMovie});
}

class TvRecommendLoaded extends MediaRecommendState {
  final List<TiVi> listTv;
  TvRecommendLoaded({required this.listTv});
}

class MediaRecommendError extends MediaRecommendState {
  final String message;
  MediaRecommendError(this.message);
}
