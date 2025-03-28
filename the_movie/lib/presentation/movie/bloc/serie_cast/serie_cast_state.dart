import 'package:the_movie/data/models/credits/credit.dart';

abstract class SerieCastState {}

class SerieCastInitial extends SerieCastState {}

class SerieCastIsLoading extends SerieCastState {}

class SerieCaseLoaded extends SerieCastState {
  final List<Credit> credits;
  SerieCaseLoaded({required this.credits});
}

class SerieCastError extends SerieCastState {
  final String message;
  SerieCastError(this.message);
}
