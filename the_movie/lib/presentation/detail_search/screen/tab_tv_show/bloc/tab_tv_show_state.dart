import 'package:equatable/equatable.dart';
import 'package:the_movie/data/models/search/search_tv.dart';

abstract class TvSearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TvSearchInitial extends TvSearchState {}

class TvSearchLoading extends TvSearchState {}

class TvSearchError extends TvSearchState {
  final String message;
  TvSearchError(this.message);

  @override
  List<Object?> get props => [message];
}

class TvSearchLoaded extends TvSearchState {
  final SearchTv tvData;
  final int page;

  TvSearchLoaded({required this.tvData, required this.page});

  @override
  List<Object?> get props => [tvData, page];
}
