import 'package:the_movie/data/models/medias/media.dart';

class TiVi extends Media{
  List<String> originCountry;
  String originalName;
  DateTime firstAirDate;
  String name;

  TiVi({
    required this.originCountry,
    required this.originalName,
    required this.firstAirDate,
    required this.name,
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
  factory TiVi.fromJson(Map<String, dynamic> json) => TiVi(
    originCountry: List<String>.from(json["origin_country"].map((x) => x)),
    originalName: json["original_name"],
    firstAirDate: DateTime.parse(json["first_air_date"]),
    name: json["name"],
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