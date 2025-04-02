import 'package:the_movie/core/utils/safe_null.dart';
import 'package:the_movie/data/models/medias/media.dart';

class TiVi extends Media {
  List<String>? originCountry;
  String? originalName;
  DateTime? firstAirDate;
  String? name;

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
    required super.charater,
  });

  @override
  factory TiVi.fromJson(Map<String, dynamic> json) => TiVi(
        originCountry: (json["origin_country"] as List<dynamic>?)
                ?.map((x) => x as String)
                .toList() ??
            [],
        originalName: SafeNull.checkString(json["original_name"]),
        firstAirDate: SafeNull.checkDateTime(json["first_air_date"]),
        name: SafeNull.checkString(json["name"]),
        backdropPath: SafeNull.checkString(json["backdrop_path"]),
        id: SafeNull.checkInt(json["id"]),
        overview: SafeNull.checkString(json["overview"]),
        mediaType: SafeNull.checkString(json["media_type"]),
        posterPath: SafeNull.checkString(json["poster_path"]),
        adult: SafeNull.checkBool(json["adult"]),
        popularity: SafeNull.checkDouble(json["popularity"]),
        voteAverage: SafeNull.checkDouble(json["vote_average"]),
        voteCount: SafeNull.checkInt(json["vote_count"]),
        originalLanguage: SafeNull.checkString(json["original_language"]),
        charater: SafeNull.checkString(json["character"]),
      );

  @override
  String getOriginalTitle() {
    return originalName ?? '';
  }

  @override
  DateTime? getReleaseDate() {
    return firstAirDate;
  }

  @override
  String getTitle() {
    return name ?? '';
  }

  @override
  String getYear() {
    String getYear =
        (getReleaseDate() != null) ? getReleaseDate()!.year.toString() : '';
    return getYear;
  }

  @override
  bool isMovie() {
    return false;
  }
}
