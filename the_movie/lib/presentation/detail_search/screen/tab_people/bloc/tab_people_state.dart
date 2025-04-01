import 'package:equatable/equatable.dart';
import 'package:the_movie/data/models/search/search_people.dart';

abstract class TabPeopleState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TabPeopleInitial extends TabPeopleState {}

class TabPeopleLoading extends TabPeopleState {}

class TabPeopleError extends TabPeopleState {
  final String message;
  TabPeopleError(this.message);

  @override
  List<Object?> get props => [message];
}

class TabPeopleLoaded extends TabPeopleState {
  final SearchPeople peopleData;
  final int page;

  TabPeopleLoaded({required this.peopleData, required this.page});

  @override
  List<Object?> get props => [peopleData, page];
}
