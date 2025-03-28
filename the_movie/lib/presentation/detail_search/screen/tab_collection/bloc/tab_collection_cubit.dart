import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/repositories/search_repository.dart';
import 'package:the_movie/data/models/search/search_collections.dart';

abstract class CollectionSearchState {}

class CollectionSearchInitial extends CollectionSearchState {}

class CollectionSearchLoading extends CollectionSearchState {}

class CollectionSearchLoaded extends CollectionSearchState {
  final SearchCollections data;
  final int page;

  CollectionSearchLoaded(this.data, this.page);
}

class CollectionSearchError extends CollectionSearchState {
  final String message;

  CollectionSearchError(this.message);
}

class CollectionSearchCubit extends Cubit<CollectionSearchState> {
  CollectionSearchCubit() : super(CollectionSearchInitial());

  Future<void> fetchCollections(String query, int page) async {
    if (query.isEmpty) return;
    emit(CollectionSearchLoading());

    try {
      final data = await SearchRepositoryImpl.instance.getSearchCollections(query, page);
      emit(CollectionSearchLoaded(data, page));
    } catch (e) {
      emit(CollectionSearchError("Failed to fetch Collections: $e"));
    }
  }
}
