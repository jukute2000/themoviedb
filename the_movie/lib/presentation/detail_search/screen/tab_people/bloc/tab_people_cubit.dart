import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/repositories/search_repository.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_people/bloc/tab_people_state.dart';

class TabPeopleCubit extends Cubit<TabPeopleState> {
  TabPeopleCubit() : super(TabPeopleInitial());

  Future<void> fetchPeople(String query, int page) async {
    if (query.isEmpty) {
      if (!isClosed) emit(TabPeopleError("Query cannot be empty"));
      return;
    }
    if (!isClosed) emit(TabPeopleLoading());

    try {
      final data =
          await SearchRepositoryImpl.instance.getSearchPeople(query, page);
      if (!isClosed) emit(TabPeopleLoaded(peopleData: data, page: page));
    } catch (e) {
      if (!isClosed) emit(TabPeopleError("Failed to fetch People: $e"));
    }
  }
}
