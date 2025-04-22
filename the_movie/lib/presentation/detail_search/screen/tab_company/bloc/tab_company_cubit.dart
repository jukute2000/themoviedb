import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/repositories/search_repository.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_company/bloc/tab_company_state.dart';

class TabCompanyCubit extends Cubit<TabCompanyState> {
  TabCompanyCubit() : super(TabCompanyInitial());

  Future<void> fetchCompanies(String query, int page) async {
    if (query.isEmpty) {
      if (!isClosed) emit(TabCompanyError("Query cannot be empty"));
      return;
    }
    if (!isClosed) emit(TabCompanyLoading());

    try {
      final data =
          await SearchRepositoryImpl.instance.getSearchCompany(query, page);
      if (!isClosed) emit(TabCompanyLoaded(companyData: data, page: page));
    } catch (e) {
      if (!isClosed) emit(TabCompanyError("Failed to fetch Companies: $e"));
    }
  }
}
