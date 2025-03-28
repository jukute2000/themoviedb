import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/repositories/search_repository.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_tv_show/bloc/tab_tv_show_state.dart';

class TvSearchCubit extends Cubit<TvSearchState> {
  TvSearchCubit() : super(TvSearchInitial());

  Future<void> fetchTvShows(String query, int page) async {
    if (query.isEmpty) {
      emit(TvSearchError("Query cannot be empty"));
      return;
    }

    emit(TvSearchLoading());

    try {
      final data = await SearchRepositoryImpl.instance.getSearchTv(query, page);
      emit(TvSearchLoaded(tvData: data, page: page));
    } catch (e) {
      emit(TvSearchError("Failed to fetch TV data: $e"));
    }
  }
}
