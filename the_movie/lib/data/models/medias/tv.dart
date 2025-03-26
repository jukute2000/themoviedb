import 'package:the_movie/data/models/medias/media.dart';

class TiVi extends Media {
  List<String> originCountry;
  String originalName;
  DateTime? firstAirDate;
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
        originCountry: (json["origin_country"] as List<dynamic>?)
                ?.map((x) => x as String)
                .toList() ??
            [],
        originalName: json["original_name"] ?? "",
        firstAirDate: json["first_air_date"] != null &&
                json["first_air_date"].toString().isNotEmpty
            ? DateTime.tryParse(json["first_air_date"])
            : null,
        name: json["name"] ?? "",
        backdropPath: json["backdrop_path"] ?? "",
        id: json["id"] ?? 0,
        overview: json["overview"] ?? "",
        mediaType: json["media_type"] ?? "",
        posterPath: json["poster_path"] ?? "",
        adult: json["adult"] ?? false,
        popularity: json["popularity"] is double
            ? json["popularity"]
            : json["popularity"] is String
                ? double.parse(json["popularity"])
                : 0.0,
        voteAverage: json["vote_average"] is double
            ? json["vote_average"]
            : json["vote_average"] is String
                ? double.parse(json["vote_average"])
                : 0,
        voteCount: json["vote_count"] is int
            ? json["vote_count"]
            : json["vote_count"] is String
                ? double.parse(json["vote_count"])
                : 0,
        originalLanguage: json["original_language"] ?? "",
      );
}
