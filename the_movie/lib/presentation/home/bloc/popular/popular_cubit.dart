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
      emit(PopularIsLoading());
    }
    try {
      List<Movie> newMovies =
          await MediaRepositoryImpl.instance.getMoviePopular();
      emit(MoviePopularLoaded(movies: newMovies));
    } catch (e) {
      emit(PopularError("Error: $e"));
    } finally {
      _isLoading = false;
    }
  }
}
