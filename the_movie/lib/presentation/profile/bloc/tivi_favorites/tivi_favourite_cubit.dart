import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/models/medias/tv.dart';
import 'package:the_movie/data/repositories/account_repository.dart';
import 'package:the_movie/presentation/profile/bloc/tivi_favorites/tivi_favourite_state.dart';

class TiviFavouriteCubit extends Cubit<TiviFavouriteState> {
  TiviFavouriteCubit() : super(TiviFavouriteInitial());
  bool _isLoading = false;

  void loadTiviFavourites({bool isLoadMode = false}) async {
    if (_isLoading) return;
    _isLoading = true;
    if (!isLoadMode) {
      if (!isClosed) emit(TiviFavouriteIsLoading());
    }
    try {
      List<TiVi> tivis =
          await AccountRepositoryImpl.instance.getTiviFavorites();
      if (!isClosed) emit(TiviFavouriteLoaded(tivis: tivis));
    } catch (e) {
      if (!isClosed) emit(TiviFavouriteError("Error: $e"));
    } finally {
      _isLoading = false;
    }
  }
}
