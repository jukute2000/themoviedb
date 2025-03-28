import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/repositories/search_repository.dart';
import 'package:the_movie/data/models/search/search_keywords.dart';

abstract class KeywordSearchState {}

class KeywordSearchInitial extends KeywordSearchState {}

class KeywordSearchLoading extends KeywordSearchState {}

class KeywordSearchLoaded extends KeywordSearchState {
  final SearchKeywords data;
  final int page;

  KeywordSearchLoaded(this.data, this.page);
}

class KeywordSearchError extends KeywordSearchState {
  final String message;

  KeywordSearchError(this.message);
}

class KeywordSearchCubit extends Cubit<KeywordSearchState> {
  KeywordSearchCubit() : super(KeywordSearchInitial());

  Future<void> fetchKeywords(String query, int page) async {
    if (query.isEmpty) return;
    emit(KeywordSearchLoading());

    try {
      final data = await SearchRepositoryImpl.instance.getSearchKeywords(query, page);
      emit(KeywordSearchLoaded(data, page));
    } catch (e) {
      emit(KeywordSearchError("Failed to fetch Keywords: $e"));
    }
  }
}
