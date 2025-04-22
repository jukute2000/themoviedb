import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/home/bloc/banner/banner_state.dart';

import '../../../../data/controller/firebase_tmdb_controller.dart';

class BannerCubit extends Cubit<BannerState> {
  BannerCubit() : super(BannerInitial());

  Future<void> loadBanner() async {
    if (!isClosed) emit(BannerIsLoading());
    try {
      var result = await FirebaseTmdbController.getInstance()
          .db
          .collection("imagesBanner")
          .get();
      if (result.docs.isNotEmpty) {
        if (!isClosed) emit(BannerLoaded(images: result.docs.first['get']));
      }
    } catch (e) {
      if (!isClosed) emit(BannerError());
    }
  }
}
