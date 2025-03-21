import 'genre.dart';

class DetailMovie {
  final bool adult;
  final String? backdropPath;
  final dynamic belongsToCollection;
  final int budget;
  final List<Genre>? genres;
  final String? homepage;
  final int id;
  final String? imdbId;
  final List<String>? originCountry;
  final String originalLanguage;
  final String originalTitle;
  final String? overview;
  final double popularity;
  final String? posterPath;
  final DateTime? releaseDate;
  final int revenue;
  final int? runtime;
  final String status;
  final String? tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  DetailMovie({
    required this.adult,
    this.backdropPath,
    this.belongsToCollection,
    required this.budget,
    this.genres,
    this.homepage,
    required this.id,
    this.imdbId,
    this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.revenue,
    this.runtime,
    required this.status,
    this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory DetailMovie.fromJson(Map<String, dynamic> json) => DetailMovie(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"],
        belongsToCollection: json["belongs_to_collection"],
        budget: json["budget"] ?? 0,
        genres: json["genres"] != null
            ? List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x)))
            : null,
        homepage: json["homepage"],
        id: json["id"] ?? 0,
        imdbId: json["imdb_id"],
        originCountry: json["origin_country"] != null
            ? List<String>.from(json["origin_country"])
            : null,
        originalLanguage: json["original_language"] ?? "unknown",
        originalTitle: json["original_title"] ?? "unknown",
        overview: json["overview"],
        popularity: (json["popularity"] as num?)?.toDouble() ?? 0.0,
        posterPath: json["poster_path"],
        releaseDate: json["release_date"] != null
            ? DateTime.tryParse(json["release_date"])
            : null,
        revenue: json["revenue"] ?? 0,
        runtime: json["runtime"],
        status: json["status"] ?? "unknown",
        tagline: json["tagline"],
        title: json["title"] ?? "unknown",
        video: json["video"] ?? false,
        voteAverage: (json["vote_average"] as num?)?.toDouble() ?? 0.0,
        voteCount: json["vote_count"] ?? 0,
      );
}
