import 'package:equatable/equatable.dart';
import 'package:the_movie/data/models/search/search_companies.dart';

abstract class TabCompanyState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TabCompanyInitial extends TabCompanyState {}

class TabCompanyLoading extends TabCompanyState {}

class TabCompanyError extends TabCompanyState {
  final String message;
  TabCompanyError(this.message);

  @override
  List<Object?> get props => [message];
}

class TabCompanyLoaded extends TabCompanyState {
  final SearchCompanies companyData;
  final int page;

  TabCompanyLoaded({required this.companyData, required this.page});

  @override
  List<Object?> get props => [companyData, page];
}
