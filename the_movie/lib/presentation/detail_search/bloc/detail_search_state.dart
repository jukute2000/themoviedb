import 'package:equatable/equatable.dart';
import 'package:the_movie/data/models/search/search_movie.dart';
import 'package:the_movie/data/models/search/search_people/search_people.dart';

import '../../../data/models/search/search_tv.dart';

abstract class DetailSearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DetailSearchInitial extends DetailSearchState {}

class DetailSearchLoading extends DetailSearchState {}

class DetailSearchLoaded extends DetailSearchState {
  final SearchTv searchTv;
  final SearchMovie movieData;
  final SearchPeople peopleData;

  DetailSearchLoaded(this.searchTv, this.movieData, this.peopleData);

  @override
  List<Object?> get props => [searchTv, movieData, peopleData];
}

class DetailSearchLoadedMoreMovie extends DetailSearchState {
  final SearchMovie movieData;

  DetailSearchLoadedMoreMovie(this.movieData);

  @override
  List<Object?> get props => [movieData];
}

class DetailSearchError extends DetailSearchState {
  final String message;

  DetailSearchError(this.message);

  @override
  List<Object?> get props => [message];
}
