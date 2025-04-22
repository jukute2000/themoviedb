import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/models/medias/movie.dart';
import 'package:the_movie/data/repositories/account_repository.dart';
import 'package:the_movie/presentation/profile/bloc/movies_favourite/movies_favourite_state.dart';

class MoviesFavouriteCubit extends Cubit<MoviesFavouriteState> {
  MoviesFavouriteCubit() : super(MoviesFavouriteInitial());
  bool _isLoading = false;

  void loadMoviesFavourites({bool isLoadMode = false}) async {
    if (_isLoading) return;
    _isLoading = true;
    if (!isLoadMode) {
      if (!isClosed) emit(MoviesFavouriteIsLoading());
    }
    try {
      List<Movie> moviess =
          await AccountRepositoryImpl.instance.getMovieFavorites();
      if (!isClosed) emit(MoviesFavouriteLoaded(moviess: moviess));
    } catch (e) {
      if (!isClosed) emit(MoviesFavouriteError("Error: $e"));
    } finally {
      _isLoading = false;
    }
  }
}
