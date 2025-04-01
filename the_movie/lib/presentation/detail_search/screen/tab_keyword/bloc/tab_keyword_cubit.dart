import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/repositories/search_repository.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_keyword/bloc/tab_keyword_state.dart';

class TabKeywordCubit extends Cubit<TabKeywordState> {
  TabKeywordCubit() : super(TabKeywordInitial());

  Future<void> fetchKeywords(String query, int page) async {
    if (query.isEmpty) {
      emit(TabKeywordError("Query cannot be empty"));
      return;
    }
    emit(TabKeywordLoading());

    try {
      final data =
          await SearchRepositoryImpl.instance.getSearchKeywords(query, page);
      emit(TabKeywordLoaded(keywordsData: data, page: page));
    } catch (e) {
      emit(TabKeywordError("Failed to fetch Keywords: $e"));
    }
  }
}
