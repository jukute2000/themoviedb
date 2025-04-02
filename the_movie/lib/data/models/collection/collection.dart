import 'package:the_movie/core/utils/safe_null.dart';

import '../medias/media.dart';

class Collection extends Media {
  String? name;

  Collection({
    required this.name,
    required super.overview,
    required super.mediaType,
    required super.popularity,
    required super.voteAverage,
    required super.voteCount,
    required super.id,
    required super.posterPath,
    required super.adult,
    required super.originalLanguage,
    required super.backdropPath,
    required super.charater,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        adult: SafeNull.checkBool(json["adult"]),
        backdropPath: SafeNull.checkString(json["backdrop_path"]),
        id: SafeNull.checkInt(json["id"]),
        name: SafeNull.checkString(json["name"]),
        originalLanguage: SafeNull.checkString(json["original_language"]),
        posterPath: SafeNull.checkString(json["poster_path"]),
        overview: SafeNull.checkString(json["overview"]),
        mediaType: SafeNull.checkString(json["media_type"]),
        popularity: SafeNull.checkDouble(json["popularity"]),
        voteAverage: SafeNull.checkDouble(json["vote_average"]),
        voteCount: SafeNull.checkInt(json["vote_count"]),
        charater: '',
      );

  @override
  String getOriginalTitle() {
    return name ?? '';
  }

  @override
  DateTime? getReleaseDate() {
    return null;
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
