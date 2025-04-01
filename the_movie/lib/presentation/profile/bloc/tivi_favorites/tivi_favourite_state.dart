import 'package:the_movie/data/models/medias/tv.dart';

abstract class TiviFavouriteState {}

class TiviFavouriteInitial extends TiviFavouriteState {}

class TiviFavouriteIsLoading extends TiviFavouriteState {}

class TiviFavouriteLoaded extends TiviFavouriteState {
  final List<TiVi> tivis;
  TiviFavouriteLoaded({required this.tivis});
}

class TiviFavouriteError extends TiviFavouriteState {
  final String message;
  TiviFavouriteError(this.message);
}
