import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/models/media_detail/detail_media/detail_movie.dart';
import 'package:the_movie/data/models/media_detail/detail_media/detail_tv.dart';
import 'package:the_movie/data/repositories/media_detail_repository.dart';
import 'package:the_movie/presentation/movie/bloc/media_detail/media_detail_state.dart';

class MediaDetailCubit extends Cubit<MediaDetailState> {
  MediaDetailCubit() : super(MediaDetailInitial());

  void loadMedia(int id, bool isMovie) async {
    emit(MediaDetailIsLoading());
    try {
      if (isMovie) {
        DetailMovie detailMovie =
            await MediaDetailRepositoryImpl.instance.getMovieDetail(id);
        emit(MovieDetailLoaded(detailMovie: detailMovie));
      } else {
        DetailTv detailTv =
            await MediaDetailRepositoryImpl.instance.getTVDetail(id);

        emit(TvDetailLoaded(
          detailTv: detailTv,
        ));
      }
    } catch (e) {
      emit(MediaDetailError("Error: $e"));
    }
  }
}
