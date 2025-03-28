import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/repositories/search_repository.dart';
import 'package:the_movie/data/models/search/search_companies.dart';

abstract class CompanySearchState {}

class CompanySearchInitial extends CompanySearchState {}

class CompanySearchLoading extends CompanySearchState {}

class CompanySearchLoaded extends CompanySearchState {
  final SearchCompanies data;
  final int page;

  CompanySearchLoaded(this.data, this.page);
}

class CompanySearchError extends CompanySearchState {
  final String message;

  CompanySearchError(this.message);
}

class CompanySearchCubit extends Cubit<CompanySearchState> {
  CompanySearchCubit() : super(CompanySearchInitial());

  Future<void> fetchCompanies(String query, int page) async {
    if (query.isEmpty) return;
    emit(CompanySearchLoading());

    try {
      final data = await SearchRepositoryImpl.instance.getSearchCompany(query, page);
      emit(CompanySearchLoaded(data, page));
    } catch (e) {
      emit(CompanySearchError("Failed to fetch Companies: $e"));
    }
  }
}
