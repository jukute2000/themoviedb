import 'package:the_movie/core/utils/safe_null.dart';

class Episode {
  final int? id;
  final String? name;
  final String? overview;
  final double? voteAverage;
  final int? voteCount;
  final DateTime? airDate;
  final int? episodeNumber;
  final String? episodeType;
  final String? productionCode;
  final int? runtime;
  final int? seasonNumber;
  final int? showId;
  final String? stillPath;

  Episode({
    required this.id,
    required this.name,
    this.overview,
    required this.voteAverage,
    required this.voteCount,
    this.airDate,
    required this.episodeNumber,
    this.episodeType,
    this.productionCode,
    this.runtime,
    required this.seasonNumber,
    required this.showId,
    this.stillPath,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        id: SafeNull.checkInt(json["id"]),
        name: SafeNull.checkString(json["name"]),
        overview: SafeNull.checkString(json["overview"]),
        voteAverage: SafeNull.checkDouble(json["vote_average"]),
        voteCount: SafeNull.checkInt(json["vote_count"]),
        airDate: SafeNull.checkDateTime(json["air_date"]),
        episodeNumber: SafeNull.checkInt(json["episode_number"]),
        episodeType: SafeNull.checkString(json["episode_type"]),
        productionCode: SafeNull.checkString(json["production_code"]),
        runtime: SafeNull.checkInt(json["runtime"]),
        seasonNumber: SafeNull.checkInt(json["season_number"]),
        showId: SafeNull.checkInt(json["show_id"]),
        stillPath: SafeNull.checkString(json["still_path"]),
      );
}
