import 'package:the_movie/data/models/media_detail/genre.dart';

abstract class DetailMedia {
  final bool? adult;
  final String? backdropPath;
  final List<Genre>? genres;
  final String? homepage;
  final int? id;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? status;
  final String? tagline;
  final double? voteAverage;
  final int? voteCount;

  DetailMedia({
    required this.adult,
    this.backdropPath,
    this.genres,
    this.homepage,
    required this.id,
    this.originCountry,
    required this.originalLanguage,
    this.overview,
    required this.popularity,
    this.posterPath,
    required this.status,
    this.tagline,
    required this.voteAverage,
    required this.voteCount,
  });

  String get genreText;
  String get releaseDateText;
  String get originText;
  String get runtimeText;
  String get titleName;
  DateTime get releaseDayMedia;

  bool isMovie();

  String roundVoteAverage() {
    return "${(voteAverage! * 10).round()}%";
  }

  bool goodMedia() {
    return (voteAverage! >= 7.5);
  }
}
