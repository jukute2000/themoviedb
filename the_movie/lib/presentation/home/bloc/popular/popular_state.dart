import 'package:the_movie/data/models/medias/movie.dart';

abstract class PopularState {}

class PopularInitial extends PopularState {}

class PopularIsLoading extends PopularState {}

class MoviePopularLoaded extends PopularState {
  final List<Movie> movies;
  MoviePopularLoaded({required this.movies});
}

class PopularError extends PopularState {
  final String message;
  PopularError(this.message);
}
