import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/models/medias/movie.dart';
import 'package:the_movie/data/models/medias/tv.dart';
import 'package:the_movie/data/repositories/media_detail_repository.dart';
import 'package:the_movie/presentation/movie/bloc/media_recommend/media_recommend_state.dart';

class MediaRecommendCubit extends Cubit<MediaRecommendState> {
  MediaRecommendCubit() : super(MediaRecommendInitial());

  void loadMedia(int id, bool isMovie) async {
    emit(MediaRecommendIsLoading());
    try {
      if (isMovie) {
        List<Movie> listMovies = await MediaDetailRepositoryImpl.instance
            .getMovieRecommendations(id);
        emit(MovieRecommendLoaded(listMovie: listMovies));
      } else {
        List<TiVi> listTv =
            await MediaDetailRepositoryImpl.instance.getTvRecommendations(id);
        emit(TvRecommendLoaded(listTv: listTv));
      }
    } catch (e) {
      emit(MediaRecommendError("Error: $e"));
    }
  }
}
