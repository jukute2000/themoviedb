import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/models/search/search_collections.dart';
import 'package:the_movie/data/models/search/search_companies.dart';
import 'package:the_movie/data/models/search/search_keywords.dart';
import 'package:the_movie/data/models/search/search_movie.dart';
import 'package:the_movie/data/models/search/search_tv.dart';
import 'package:the_movie/data/repositories/search_repository.dart';

import '../../../data/models/search/search_people.dart';
import 'detail_search_state.dart';

class DetailSearchCubit extends Cubit<DetailSearchState> {
  DetailSearchCubit() : super(DetailSearchInitial());
  final Map<int, int> _currentPages = {0: 1, 1: 1, 2: 1, 3: 1, 4: 1, 5: 1, 6: 1};

  Future<void> fetchData(String query, int page) async {
    if (query.isEmpty) return;

    emit(DetailSearchLoading());

    try {
      SearchTv tvData =
          await SearchRepositoryImpl.instance.getSearchTv(query, page);
      SearchMovie movieData =
          await SearchRepositoryImpl.instance.getSearchMovies(query, page);
      SearchPeople peopleData =
          await SearchRepositoryImpl.instance.getSearchPeople(query, page);
      SearchCollections collectionsData =
          await SearchRepositoryImpl.instance.getSearchCollections(query, page);
      SearchKeywords keywordsData =
          await SearchRepositoryImpl.instance.getSearchKeywords(query, page);
      SearchCompanies companiesData =
          await SearchRepositoryImpl.instance.getSearchCompany(query, page);

      emit(DetailSearchLoaded(tvData, movieData, peopleData, collectionsData,
          keywordsData, companiesData, _currentPages));
    } catch (e) {
      emit(DetailSearchError("Failed to fetch data: $e"));
    }
  }

  Future<void> fetchDataMovie(String query, int page) async {
    if (query.isEmpty) return;

    final currentState = state;
    if (currentState is DetailSearchLoaded) {
      emit(DetailSearchLoading());

      _currentPages[1] = page;

      try {
        SearchMovie movieData =
            await SearchRepositoryImpl.instance.getSearchMovies(query, page);
        emit(DetailSearchLoaded(
            currentState.searchTv,
            movieData,
            currentState.peopleData,
            currentState.collectionsData,
            currentState.keywordsData,
            currentState.companiesData,
            _currentPages));
      } catch (e) {
        emit(DetailSearchError("Failed to fetch movie data: $e"));
      }
    }
  }

  Future<void> fetchDataPeople(String query, int page) async {
    if (query.isEmpty) return;

    final currentState = state;
    if (currentState is DetailSearchLoaded) {
      emit(DetailSearchLoading());
      _currentPages[2] = page;
      try {
        SearchPeople peopleData =
            await SearchRepositoryImpl.instance.getSearchPeople(query, page);
        emit(DetailSearchLoaded(
            currentState.searchTv,
            currentState.movieData,
            peopleData,
            currentState.collectionsData,
            currentState.keywordsData,
            currentState.companiesData,
            _currentPages));
      } catch (e) {
        emit(DetailSearchError("Failed to fetch people data: $e"));
      }
    }
  }

  Future<void> fetchDataTvShow(String query, int page) async {
    if (query.isEmpty) return;

    final currentState = state;
    if (currentState is DetailSearchLoaded) {
      emit(DetailSearchLoading());
      _currentPages[0] = page;

      try {
        SearchTv tvData =
            await SearchRepositoryImpl.instance.getSearchTv(query, page);
        emit(DetailSearchLoaded(
            tvData,
            currentState.movieData,
            currentState.peopleData,
            currentState.collectionsData,
            currentState.keywordsData,
            currentState.companiesData,
            _currentPages));
      } catch (e) {
        emit(DetailSearchError("Failed to fetch TV show data: $e"));
      }
    }
  }

  Future<void> fetchDataCollection(String query, int page) async {
    if (query.isEmpty) return;

    final currentState = state;
    if (currentState is DetailSearchLoaded) {
      emit(DetailSearchLoading());
      _currentPages[3] = page;

      try {
        SearchCollections collectionsData =
            await SearchRepositoryImpl.instance.getSearchCollections(query, page);
        emit(DetailSearchLoaded(
            currentState.searchTv,
            currentState.movieData,
            currentState.peopleData,
            collectionsData,
            currentState.keywordsData,
            currentState.companiesData,
            _currentPages));
      } catch (e) {
        emit(DetailSearchError("Failed to fetch collection data: $e"));
      }
    }
  }

  Future<void> fetchDataKeyword(String query, int page) async {
    if (query.isEmpty) return;

    final currentState = state;
    if (currentState is DetailSearchLoaded) {
      emit(DetailSearchLoading());
      _currentPages[4] = page;

      try {
        SearchKeywords keywordsData =
            await SearchRepositoryImpl.instance.getSearchKeywords(query, page);
        emit(DetailSearchLoaded(
            currentState.searchTv,
            currentState.movieData,
            currentState.peopleData,
            currentState.collectionsData,
            keywordsData,
            currentState.companiesData,
            _currentPages));
      } catch (e) {
        emit(DetailSearchError("Failed to fetch keyword data: $e"));
      }
    }
  }

  Future<void> fetchDataCompany(String query, int page) async {
    if (query.isEmpty) return;

    final currentState = state;
    if (currentState is DetailSearchLoaded) {
      emit(DetailSearchLoading());
      _currentPages[5] = page;

      try {
        SearchCompanies companiesData =
            await SearchRepositoryImpl.instance.getSearchCompany(query, page);
        emit(DetailSearchLoaded(
            currentState.searchTv,
            currentState.movieData,
            currentState.peopleData,
            currentState.collectionsData,
            currentState.keywordsData,
            companiesData,
            _currentPages));
      } catch (e) {
        emit(DetailSearchError("Failed to fetch company data: $e"));
      }
    }
  }
}
