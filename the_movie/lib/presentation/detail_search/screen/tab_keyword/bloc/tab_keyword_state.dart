import 'package:equatable/equatable.dart';
import 'package:the_movie/data/models/search/search_keywords.dart';

abstract class TabKeywordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TabKeywordInitial extends TabKeywordState {}

class TabKeywordLoading extends TabKeywordState {}

class TabKeywordError extends TabKeywordState {
  final String message;
  TabKeywordError(this.message);

  @override
  List<Object?> get props => [message];
}

class TabKeywordLoaded extends TabKeywordState {
  final SearchKeywords keywordsData;
  final int page;

  TabKeywordLoaded({required this.keywordsData, required this.page});

  @override
  List<Object?> get props => [keywordsData, page];
}
