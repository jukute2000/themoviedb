import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/models/medias/movie.dart';
import 'package:the_movie/data/models/medias/tv.dart';
import 'package:the_movie/data/repositories/media_detail_repository.dart';
import 'package:the_movie/presentation/movie/bloc/media_recommend/media_recommend_state.dart';

class MediaRecommendCubit extends Cubit<MediaRecommendState> {
  MediaRecommendCubit() : super(MediaRecommendInitial());

  void loadMedia(int id, bool isMovie) async {
    if (!isClosed) emit(MediaRecommendIsLoading());
    try {
      if (isMovie) {
        List<Movie> listMovies = await MediaDetailRepositoryImpl.instance
            .getMovieRecommendations(id);
        if (!isClosed) emit(MovieRecommendLoaded(listMovie: listMovies));
      } else {
        List<TiVi> listTv =
            await MediaDetailRepositoryImpl.instance.getTvRecommendations(id);
        if (!isClosed) emit(TvRecommendLoaded(listTv: listTv));
      }
    } catch (e) {
      if (!isClosed) emit(MediaRecommendError("Error: $e"));
    }
  }
}
