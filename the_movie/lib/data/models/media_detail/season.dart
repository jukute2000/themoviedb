import 'package:the_movie/core/utils/safe_null.dart';

class Season {
  final DateTime? airDate;
  final int? episodeCount;
  final int? id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;
  final double? voteAverage;

  Season({
    this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    this.overview,
    this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  factory Season.fromJson(Map<String, dynamic> json) => Season(
        airDate: SafeNull.checkDateTime(json["air_date"]),
        episodeCount: SafeNull.checkInt(json["episode_count"]),
        id: SafeNull.checkInt(json["id"]),
        name: SafeNull.checkString(json["name"]),
        overview: SafeNull.checkString(json["overview"]),
        posterPath: SafeNull.checkString(json["poster_path"]),
        seasonNumber: SafeNull.checkInt(json["season_number"]),
        voteAverage: SafeNull.checkDouble(json["vote_average"]),
      );
}
