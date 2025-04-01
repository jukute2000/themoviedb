import 'package:equatable/equatable.dart';
import 'package:the_movie/data/models/search/search_movie.dart';

abstract class TabMovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TabMovieInitial extends TabMovieState {}

class TabMovieLoading extends TabMovieState {}

class TabMovieError extends TabMovieState {
  final String message;
  TabMovieError(this.message);

  @override
  List<Object?> get props => [message];
}

class TabMovieLoaded extends TabMovieState {
  final SearchMovie movieData;
  final int page;

  TabMovieLoaded({required this.movieData, required this.page});

  @override
  List<Object?> get props => [movieData, page];
}
