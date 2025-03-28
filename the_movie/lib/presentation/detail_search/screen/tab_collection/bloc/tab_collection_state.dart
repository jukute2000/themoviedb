import 'package:equatable/equatable.dart';
import 'package:the_movie/data/models/search/search_movie.dart';

abstract class MovieSearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieSearchInitial extends MovieSearchState {}

class MovieSearchLoading extends MovieSearchState {}

class MovieSearchError extends MovieSearchState {
  final String message;
  MovieSearchError(this.message);

  @override
  List<Object?> get props => [message];
}

class MovieSearchLoaded extends MovieSearchState {
  final SearchMovie movieData;
  final int page;

  MovieSearchLoaded({required this.movieData, required this.page});

  @override
  List<Object?> get props => [movieData, page];
}
