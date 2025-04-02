import 'package:the_movie/core/utils/safe_null.dart';
import 'package:the_movie/data/models/medias/media.dart';

class Movie extends Media {
  String? title;
  String? originalTitle;
  List<int>? genreIds;
  DateTime? releaseDate;
  bool? video;

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
    required super.charater,
  });

  @override
  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        title: SafeNull.checkString(json["title"]),
        originalTitle: SafeNull.checkString(json["original_title"]),
        genreIds: (json["genre_ids"] as List<dynamic>?)
                ?.map((x) => x as int)
                .toList() ??
            [],
        releaseDate: SafeNull.checkDateTime(json["release_date"]),
        video: SafeNull.checkBool(json["video"]),
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
    return originalTitle!;
  }

  @override
  DateTime? getReleaseDate() {
    return releaseDate;
  }

  @override
  String getTitle() {
    return title ?? '';
  }

  @override
  String getYear() {
    String getYear =
        (getReleaseDate() != null) ? getReleaseDate()!.year.toString() : '';
    return getYear;
  }

  @override
  bool isMovie() {
    return true;
  }
}
