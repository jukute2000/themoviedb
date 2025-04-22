import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/controller/firebase_tmdb_controller.dart';
import 'package:the_movie/data/models/media_detail/detail_media/detail_meida.dart';
import 'package:the_movie/data/models/media_detail/detail_media/detail_movie.dart';
import 'package:the_movie/data/models/media_detail/detail_media/detail_tv.dart';
import 'package:the_movie/data/repositories/media_detail_repository.dart';
import 'package:the_movie/presentation/home/bloc/recomened/recommened_state.dart';
import '../../../../data/models/recommened/recommened_media.dart';

class RecommenedCubit extends Cubit<RecommenedState> {
  RecommenedCubit() : super(RecommenedInitial());

  Future<void> loadRecommened() async {
    if (!isClosed) emit(RecommenedIsLoading());
    try {
      List<RecommenedMedia> recommened =
          await FirebaseTmdbController.getInstance()
              .db
              .collection("recommenedMedia")
              .get()
              .then((value) => value.docs
                  .map((e) => RecommenedMedia.fromJson(e.data()))
                  .toList());
      List<DetailMedia> mediaDetails = [];
      for (RecommenedMedia item in recommened) {
        if (item.isMovie) {
          DetailMovie detailMovie =
              await MediaDetailRepositoryImpl.instance.getMovieDetail(item.id);
          mediaDetails.add(detailMovie);
        } else {
          DetailTv detailTv =
              await MediaDetailRepositoryImpl.instance.getTVDetail(item.id);
          mediaDetails.add(detailTv);
        }
      }
      if (!isClosed) emit(RecommenedLoaded(listMediaDetail: mediaDetails));
    } catch (e) {
      if (!isClosed) emit(RecommenedError("Error: $e"));
    }
  }
}
