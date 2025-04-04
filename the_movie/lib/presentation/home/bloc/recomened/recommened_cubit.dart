import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/controller/firebase_tmdb_controller.dart';
import 'package:the_movie/presentation/home/bloc/recomened/recommened_state.dart';
import '../../../../data/models/recommened/recommened_media.dart';

class RecommenedCubit extends Cubit<RecommenedState> {
  RecommenedCubit() : super(RecommenedInitial());

  Future<void> loadRecommened() async {
    emit(RecommenedIsLoading());
    try {
      List<RecommenedMedia> recommened =
          await FirebaseTmdbController.getInstance()
              .db
              .collection("recommenedMedia")
              .get()
              .then((value) => value.docs
                  .map((e) => RecommenedMedia.fromJson(e.data()))
                  .toList());
      print(recommened.length);
      emit(RecommenedLoaded());
    } catch (e) {
      emit(RecommenedError());
    }
  }
}
