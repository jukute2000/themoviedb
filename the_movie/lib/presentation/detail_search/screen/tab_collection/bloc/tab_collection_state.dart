import 'package:equatable/equatable.dart';
import 'package:the_movie/data/models/search/search_collections.dart';

abstract class TabCollectionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TabCollectionInitial extends TabCollectionState {}

class TabCollectionLoading extends TabCollectionState {}

class TabCollectionError extends TabCollectionState {
  final String message;
  TabCollectionError(this.message);

  @override
  List<Object?> get props => [message];
}

class TabCollectionLoaded extends TabCollectionState {
  final SearchCollections collectionsData;
  final int page;

  TabCollectionLoaded({required this.collectionsData, required this.page});

  @override
  List<Object?> get props => [collectionsData, page];
}
