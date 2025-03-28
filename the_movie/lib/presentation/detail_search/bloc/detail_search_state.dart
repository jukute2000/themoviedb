import 'package:equatable/equatable.dart';
import 'package:the_movie/data/models/search/search_collections.dart';
import 'package:the_movie/data/models/search/search_companies.dart';
import 'package:the_movie/data/models/search/search_keywords.dart';
import 'package:the_movie/data/models/search/search_movie.dart';

import '../../../data/models/search/search_people.dart';
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
  final SearchCollections collectionsData;
  final SearchKeywords keywordsData;
  final SearchCompanies companiesData;
  final Map<int, int> currentPages;

  DetailSearchLoaded(
      this.searchTv,
      this.movieData,
      this.peopleData,
      this.collectionsData,
      this.keywordsData,
      this.companiesData,
      this.currentPages);
}

class DetailSearchError extends DetailSearchState {
  final String message;

  DetailSearchError(this.message);

  @override
  List<Object?> get props => [message];
}
