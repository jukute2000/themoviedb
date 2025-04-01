import 'package:the_movie/core/utils/safe_null.dart';

class Crew {
  final String? creditId;
  final String? department;
  final String? job;
  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? firstAirDate;
  final String? title;
  final String? name;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;
  final String? mediaType;
  Crew({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.firstAirDate,
    required this.name,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.mediaType,
    required this.creditId,
    required this.department,
    required this.job,
  });

  factory Crew.fromJson(Map<String, dynamic> json) => Crew(
        name: SafeNull.checkString(json["name"]),
        adult: SafeNull.checkBool(json["adult"]),
        backdropPath: SafeNull.checkString(json["backdrop_path"]),
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: SafeNull.checkInt(json["id"]),
        originalLanguage: SafeNull.checkString(json["original_language"]),
        originalTitle: SafeNull.checkString(json["original_title"]),
        overview: SafeNull.checkString(json["overview"]),
        popularity: SafeNull.checkDouble(json["popularity"]),
        posterPath: SafeNull.checkString(json["poster_path"]),
        releaseDate: SafeNull.checkString(json["release_date"]),
        title: SafeNull.checkString(json["title"]),
        video: SafeNull.checkBool(json["video"]),
        voteAverage: SafeNull.checkDouble(json["vote_average"]),
        voteCount: SafeNull.checkInt(json["vote_count"]),
        creditId: SafeNull.checkString(json["credit_id"]),
        department: SafeNull.checkString(json["department"]),
        job: SafeNull.checkString(json["job"]),
        mediaType: SafeNull.checkString(json["media_type"]),
        firstAirDate: SafeNull.checkString(json["first_air_date"]),
      );

  int getDateTime() {
    if (releaseDate != null) {
      return DateTime.parse(releaseDate!).year;
    }
    if (firstAirDate != null) {
      return DateTime.parse(firstAirDate!).year;
    }
    return 0;
  }

  bool isMovie() {
    if (mediaType == "movie") {
      return true;
    }
    return false;
  }

  String? getTitle() {
    if (isMovie()) {
      return title;
    }
    return name;
  }
}
