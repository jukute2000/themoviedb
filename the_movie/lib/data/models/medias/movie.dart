import 'package:the_movie/data/models/medias/media.dart';

class Movie extends Media {
  String title;
  String originalTitle;
  List<int> genreIds;
  DateTime? releaseDate;
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
        title: json["title"] ?? "",
        originalTitle: json["original_title"] ?? "",
        genreIds: (json["genre_ids"] as List<dynamic>?)
                ?.map((x) => x as int)
                .toList() ??
            [],
        releaseDate: json["release_date"] != null &&
                json["release_date"].toString().isNotEmpty
            ? DateTime.tryParse(json["release_date"])
            : null,
        video: json["video"] ?? false,
        backdropPath: json["backdrop_path"] ?? "",
        id: json["id"] ?? 0,
        overview: json["overview"] ?? "",
        mediaType: json["media_type"] ?? "",
        posterPath: json["poster_path"] ?? "",
        adult: json["adult"] ?? false,
        popularity: (json["popularity"]?.toDouble()) ?? 0.0,
        voteAverage: (json["vote_average"]?.toDouble()) ?? 0.0,
        voteCount: json["vote_count"] ?? 0,
        originalLanguage: json["original_language"] ?? "",
      );
}
