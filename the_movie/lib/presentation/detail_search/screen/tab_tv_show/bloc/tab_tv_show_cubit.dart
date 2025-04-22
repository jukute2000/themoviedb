import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/repositories/search_repository.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_tv_show/bloc/tab_tv_show_state.dart';

class TabTvShowCubit extends Cubit<TabTvShowState> {
  TabTvShowCubit() : super(TabTvShowInitial());

  Future<void> fetchTvShows(String query, int page) async {
    if (query.isEmpty) {
      if (!isClosed) emit(TabTvShowError("Query cannot be empty"));
      return;
    }

    if (!isClosed) emit(TabTvShowLoading());

    try {
      final data = await SearchRepositoryImpl.instance.getSearchTv(query, page);
      if (!isClosed) emit(TabTvShowLoaded(tvData: data, page: page));
    } catch (e) {
      if (!isClosed) emit(TabTvShowError("Failed to fetch TV data: $e"));
    }
  }
}
