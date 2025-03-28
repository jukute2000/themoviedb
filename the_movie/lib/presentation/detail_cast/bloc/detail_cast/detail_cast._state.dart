import 'package:the_movie/data/models/people/people_detail.dart';

abstract class DetailCastState {}

class DetailCastInitial extends DetailCastState {}

class DetailCastIsLoading extends DetailCastState {}

class DetailCastLoaded extends DetailCastState {
  final PeopleDetail detailPeople;
  DetailCastLoaded({required this.detailPeople});
}

class DetailCastError extends DetailCastState {
  final String message;
  DetailCastError(this.message);
}
