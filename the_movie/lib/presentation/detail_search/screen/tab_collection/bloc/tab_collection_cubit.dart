import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/repositories/search_repository.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_collection/bloc/tab_collection_state.dart';

class TabCollectionCubit extends Cubit<TabCollectionState> {
  TabCollectionCubit() : super(TabCollectionInitial());

  Future<void> fetchCollections(String query, int page) async {
    if (query.isEmpty) {
      if (!isClosed) emit(TabCollectionError("Query cannot be empty"));
      return;
    }
    if (!isClosed) emit(TabCollectionLoading());

    try {
      final data =
          await SearchRepositoryImpl.instance.getSearchCollections(query, page);
      if (!isClosed) {
        emit(TabCollectionLoaded(collectionsData: data, page: page));
      }
    } catch (e) {
      if (!isClosed) {
        emit(TabCollectionError("Failed to fetch Collections: $e"));
      }
    }
  }
}
