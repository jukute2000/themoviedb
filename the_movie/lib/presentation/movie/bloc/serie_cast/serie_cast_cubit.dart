import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/models/credits/credit.dart';
import 'package:the_movie/data/repositories/media_detail_repository.dart';
import 'package:the_movie/presentation/movie/bloc/serie_cast/serie_cast_state.dart';

class SerieCastCubit extends Cubit<SerieCastState> {
  SerieCastCubit() : super(SerieCastInitial());

  void loadCredit(int id, bool isMovie) async {
    emit(SerieCastIsLoading());
    try {
      List<Credit> listCredits = await MediaDetailRepositoryImpl.instance
          .getCredits(id: id, isMovie: isMovie);
      emit(SerieCaseLoaded(credits: listCredits));
    } catch (e) {
      emit(SerieCastError("Error: $e"));
    }
  }
}
