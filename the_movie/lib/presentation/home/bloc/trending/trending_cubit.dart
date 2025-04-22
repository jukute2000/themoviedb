import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/models/medias/media.dart';
import 'package:the_movie/data/repositories/media_repository.dart';
import 'package:the_movie/presentation/home/bloc/trending/trending_state.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TrendingCubit extends Cubit<TrendingState> {
  TrendingCubit() : super(TrendingInitial());
  bool _isLoading = false;

  void loadMedias({bool isLoadMode = false}) async {
    if (_isLoading) return;
    _isLoading = true;
    if (!isLoadMode) {
      if (!isClosed) emit(TrendingIsLoading());
    }
    try {
      List<Media> newMedias = await MediaRepositoryImpl.instance
          .getMediaTrending(1, TimeWindow.day);
      if (!isClosed) emit(MediasTrendingLoaded(medias: newMedias));
    } catch (e) {
      if (!isClosed) emit(TrendingError("Error: $e"));
    } finally {
      _isLoading = false;
    }
  }
}
