import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/models/search/search_movie.dart';
import 'package:the_movie/data/models/search/search_people/search_people.dart';
import 'package:the_movie/data/models/search/search_tv.dart';
import 'package:the_movie/data/repositories/search_repository.dart';

import 'detail_search_state.dart';

class DetailSearchCubit extends Cubit<DetailSearchState> {
  DetailSearchCubit() : super(DetailSearchInitial());

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

      emit(DetailSearchLoaded(tvData, movieData, peopleData));
    } catch (e) {
      emit(DetailSearchError("Failed to fetch data: $e"));
    }
  }

  Future<void> fetchDataMovie(String query, int page) async {
    if (query.isEmpty) return;

    final currentState = state;
    if (currentState is DetailSearchLoaded) {
      emit(DetailSearchLoading());

      try {
        SearchMovie movieData =
            await SearchRepositoryImpl.instance.getSearchMovies(query, page);

        emit(DetailSearchLoaded(
          currentState.searchTv,
          movieData,
          currentState.peopleData,
        ));
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

      try {
        SearchPeople peopleData =
            await SearchRepositoryImpl.instance.getSearchPeople(query, page);

        emit(DetailSearchLoaded(
          currentState.searchTv,
          currentState.movieData,
          peopleData,
        ));
      } catch (e) {
        emit(DetailSearchError("Failed to fetch movie data: $e"));
      }
    }
  }

  Future<void> fetchDataTvShow(String query, int page) async {
    if (query.isEmpty) return;

    final currentState = state;
    if (currentState is DetailSearchLoaded) {
      emit(DetailSearchLoading());

      try {
        SearchTv tvData =
            await SearchRepositoryImpl.instance.getSearchTv(query, page);

        emit(DetailSearchLoaded(
          tvData,
          currentState.movieData,
          currentState.peopleData,
        ));
      } catch (e) {
        emit(DetailSearchError("Failed to fetch movie data: $e"));
      }
    }
  }
}
