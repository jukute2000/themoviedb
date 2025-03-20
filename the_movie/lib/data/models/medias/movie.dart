import 'package:the_movie/data/models/medias/media.dart';

class Movie extends Media{
  String title;
  String originalTitle;
  List<int> genreIds;
  DateTime releaseDate;
  bool video;

  Movie({
    required this.title,
    required this.originalTitle,
    required this.genreIds,
    required this.releaseDate,
    required this.video,
    required super.backdropPath,
    required super.id,
    required super.overview,
    required super.mediaType,
    required super.posterPath,
    required super.adult,
    required super.popularity,
    required super.voteAverage,
    required super.voteCount,
    required super.originalLanguage,
  });


  @override
  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    title: json["title"],
    originalTitle: json["original_title"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    releaseDate: DateTime.parse(json["release_date"]),
    video: json["video"],
    backdropPath: json["backdrop_path"],
    id: json["id"],
    overview: json["overview"],
    mediaType: json["media_type"],
    posterPath: json["poster_path"],
    adult: json["adult"],
    popularity: json["popularity"].toDouble(),
    voteAverage: json["vote_average"].toDouble(),
    voteCount: json["vote_count"],
    originalLanguage: json["original_language"],
  );
}