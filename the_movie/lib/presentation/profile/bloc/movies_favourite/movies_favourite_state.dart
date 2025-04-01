import 'package:the_movie/data/models/medias/movie.dart';

abstract class MoviesFavouriteState {}

class MoviesFavouriteInitial extends MoviesFavouriteState {}

class MoviesFavouriteIsLoading extends MoviesFavouriteState {}

class MoviesFavouriteLoaded extends MoviesFavouriteState {
  final List<Movie> moviess;
  MoviesFavouriteLoaded({required this.moviess});
}

class MoviesFavouriteError extends MoviesFavouriteState {
  final String message;
  MoviesFavouriteError(this.message);
}
