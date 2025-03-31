import 'package:the_movie/data/models/credits/external.dart';
import 'package:the_movie/data/models/medias/movie.dart';
import 'package:the_movie/data/models/people/people_detail.dart';
import '../../../../data/models/credits/combined_credit.dart/crew.dart';
import '../../../../data/models/medias/media.dart';

abstract class DetailCastState {}

class DetailCastInitial extends DetailCastState {}

class DetailCastIsLoading extends DetailCastState {}

class DetailCastLoaded extends DetailCastState {
  final PeopleDetail detailPeople;
  final External external;
  final List<Movie> movies;
  final Map<String, List<Crew>> crews;
  final List<Media> medias;
  DetailCastLoaded(
      {required this.detailPeople,
      required this.external,
      required this.movies,
      required this.crews,
      required this.medias});
}

class DetailCastError extends DetailCastState {
  final String message;
  DetailCastError(this.message);
}
