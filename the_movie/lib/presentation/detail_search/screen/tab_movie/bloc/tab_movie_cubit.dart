import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/repositories/search_repository.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_collection/bloc/tab_collection_state.dart';

class MovieSearchCubit extends Cubit<MovieSearchState> {
  MovieSearchCubit() : super(MovieSearchInitial());

  Future<void> fetchMovieData(String query, int page) async {

    if (query.isEmpty) return;

    emit(MovieSearchLoading());

    try {
      final data = await SearchRepositoryImpl.instance.getSearchMovies(query, page);
      print("✅ Movies fetched: ${data.totalResults}");

      emit(MovieSearchLoaded(movieData: data, page: page));

    } catch (e) {
      emit(MovieSearchError("Failed to fetch Movie data: $e"));
    }
  }
}
