import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/repositories/search_repository.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_company/bloc/tab_company_state.dart';


class TabCompanyCubit extends Cubit<TabCompanyState> {
  TabCompanyCubit() : super(TabCompanyInitial());

  Future<void> fetchCompanies(String query, int page) async {
    if (query.isEmpty) {
      emit(TabCompanyError("Query cannot be empty"));
      return;}
    emit(TabCompanyLoading());

    try {
      final data = await SearchRepositoryImpl.instance.getSearchCompany(query, page);
      emit(TabCompanyLoaded(companyData: data,page: page));
    } catch (e) {
      emit(TabCompanyError("Failed to fetch Companies: $e"));
    }
  }
}
