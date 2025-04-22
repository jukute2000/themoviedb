import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/models/keyword/keyword.dart';
import 'package:the_movie/data/repositories/media_detail_repository.dart';
import 'package:the_movie/presentation/movie/bloc/key_word/key_word_state.dart';

class KeyWordCubit extends Cubit<KeyWordState> {
  KeyWordCubit() : super(KeyWordInitial());

  void loadKeyWord(int id, bool isMovie) async {
    if (!isClosed) emit(KeyWordIsLoading());
    try {
      if (isMovie) {
        List<Keyword> listKeyWords = await MediaDetailRepositoryImpl.instance
            .getKeywords(id: id, isMovie: isMovie);
        if (!isClosed) emit(KeyWordLoaded(listKeyWord: listKeyWords));
      } else {
        List<Keyword> listKeyWords = await MediaDetailRepositoryImpl.instance
            .getKeywords(id: id, isMovie: isMovie);
        if (!isClosed) emit(KeyWordLoaded(listKeyWord: listKeyWords));
      }
    } catch (e) {
      if (!isClosed) emit(KeyWordError("Error: $e"));
    }
  }
}
