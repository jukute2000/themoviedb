import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/models/medias/movie.dart';
import 'package:the_movie/data/repositories/media_repository.dart';
import 'package:the_movie/presentation/home/bloc/popular/popular_state.dart';

class PopularCubit extends Cubit<PopularState> {
  PopularCubit() : super(PopularInitial());
  bool _isLoading = false;

  void loadMovie({bool isLoadMode = false}) async {
    if (_isLoading) return;
    _isLoading = true;
    if (!isLoadMode) {
      if (!isClosed) emit(PopularIsLoading());
    }
    try {
      List<Movie> newMovies =
          await MediaRepositoryImpl.instance.getMoviePopular();
      if (!isClosed) emit(MoviePopularLoaded(movies: newMovies));
    } catch (e) {
      if (!isClosed) emit(PopularError("Error: $e"));
    } finally {
      _isLoading = false;
    }
  }
}
