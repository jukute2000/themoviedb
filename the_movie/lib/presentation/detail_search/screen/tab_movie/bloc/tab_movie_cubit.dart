import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/repositories/search_repository.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_movie/bloc/tab_movie_state.dart';

class TabMovieCubit extends Cubit<TabMovieState> {
  TabMovieCubit() : super(TabMovieInitial());

  Future<void> fetchMovieData(String query, int page) async {
    if (query.isEmpty) {
      emit(TabMovieError("Query cannot be empty"));
      return;
    }

    emit(TabMovieLoading());

    try {
      final data =
          await SearchRepositoryImpl.instance.getSearchMovies(query, page);

      emit(TabMovieLoaded(movieData: data, page: page));
    } catch (e) {
      emit(TabMovieError("Failed to fetch Movie data: $e"));
    }
  }
}
