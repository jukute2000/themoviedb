import 'package:equatable/equatable.dart';
import 'package:the_movie/data/models/search/search_tv.dart';

abstract class TabTvShowState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TabTvShowInitial extends TabTvShowState {}

class TabTvShowLoading extends TabTvShowState {}

class TabTvShowError extends TabTvShowState {
  final String message;
  TabTvShowError(this.message);

  @override
  List<Object?> get props => [message];
}

class TabTvShowLoaded extends TabTvShowState {
  final SearchTv tvData;
  final int page;

  TabTvShowLoaded({required this.tvData, required this.page});

  @override
  List<Object?> get props => [tvData, page];
}
