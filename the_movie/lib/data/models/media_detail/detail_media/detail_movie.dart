import 'package:easy_localization/easy_localization.dart';
import 'package:the_movie/core/utils/formatRuntime.dart';
import 'package:the_movie/core/utils/safe_null.dart';
import 'package:the_movie/data/models/media_detail/detail_media/detail_meida.dart';
import 'package:the_movie/data/models/media_detail/genre.dart';

class DetailMovie extends DetailMedia {
  final dynamic belongsToCollection;
  final int? budget;
  final String? originalTitle;
  final DateTime? releaseDate;
  final int? revenue;
  final int? runtime;
  final String? title;
  final bool? video;
  final String? imdbId;

  DetailMovie({
    required super.adult,
    super.backdropPath,
    super.genres,
    super.homepage,
    required super.id,
    super.originCountry,
    required super.originalLanguage,
    super.overview,
    required super.popularity,
    super.posterPath,
    required super.status,
    super.tagline,
    required super.voteAverage,
    required super.voteCount,
    this.belongsToCollection,
    required this.budget,
    required this.originalTitle,
    this.releaseDate,
    required this.revenue,
    this.runtime,
    required this.title,
    required this.video,
    this.imdbId,
  });

  factory DetailMovie.fromJson(Map<String, dynamic> json) => DetailMovie(
        adult: SafeNull.checkBool(json["adult"]),
        backdropPath: SafeNull.checkString(json["backdrop_path"]),
        belongsToCollection: json["belongs_to_collection"],
        budget: SafeNull.checkInt(json["budget"]),
        genres: json["genres"] != null
            ? List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x)))
            : null,
        homepage: SafeNull.checkString(json["homepage"]),
        id: SafeNull.checkInt(json["id"]),
        imdbId: SafeNull.checkString(json["imdb_id"]),
        originCountry: json["origin_country"] != null
            ? List<String>.from(json["origin_country"])
            : null,
        originalLanguage: SafeNull.checkString(json["original_language"]),
        originalTitle: SafeNull.checkString(json["original_title"]),
        overview: SafeNull.checkString(json["overview"]),
        popularity: SafeNull.checkDouble(json["popularity"]),
        posterPath: json["poster_path"],
        releaseDate: SafeNull.checkDateTime(json["release_date"]),
        revenue: SafeNull.checkInt(json["revenue"]),
        runtime: SafeNull.checkInt(json["runtime"]),
        status: SafeNull.checkString(json["status"]),
        tagline: SafeNull.checkString(json["tagline"]),
        title: SafeNull.checkString(json["title"]),
        video: SafeNull.checkBool(json["video"]),
        voteAverage: SafeNull.checkDouble(json["vote_average"]),
        voteCount: SafeNull.checkInt(json["vote_count"]),
      );

  @override
  String get genreText => genres?.map((genre) => genre.name).join(', ') ?? '';

  @override
  String get releaseDateText => releaseDate != null
      ? DateFormat('MM/dd/yyyy').format(releaseDate!)
      : "N/A";

  @override
  String get originText => originCountry?.join(', ') ?? '';

  @override
  String get runtimeText => formatRuntime(runtime ?? 0);

  @override
  DateTime get releaseDayMedia => releaseDate ?? DateTime.now();

  @override
  String get titleName => title ?? '';
  
  @override
  bool isMovie() {
    return true;
  }
}
