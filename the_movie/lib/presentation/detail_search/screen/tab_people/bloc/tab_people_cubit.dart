import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/repositories/search_repository.dart';
import 'package:the_movie/data/models/search/search_people.dart';

abstract class PeopleSearchState {}

class PeopleSearchInitial extends PeopleSearchState {}

class PeopleSearchLoading extends PeopleSearchState {}

class PeopleSearchLoaded extends PeopleSearchState {
  final SearchPeople data;
  final int page;

  PeopleSearchLoaded(this.data, this.page);
}

class PeopleSearchError extends PeopleSearchState {
  final String message;

  PeopleSearchError(this.message);
}

class PeopleSearchCubit extends Cubit<PeopleSearchState> {
  PeopleSearchCubit() : super(PeopleSearchInitial());

  Future<void> fetchPeople(String query, int page) async {
    if (query.isEmpty) return;
    emit(PeopleSearchLoading());

    try {
      final data = await SearchRepositoryImpl.instance.getSearchPeople(query, page);
      emit(PeopleSearchLoaded(data, page));
    } catch (e) {
      emit(PeopleSearchError("Failed to fetch People: $e"));
    }
  }
}
