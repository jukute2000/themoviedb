class Season {
  final DateTime? airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String? overview;
  final String? posterPath;
  final int seasonNumber;
  final double voteAverage;

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
        airDate: json["air_date"] != null
            ? DateTime.tryParse(json["air_date"])
            : null,
        episodeCount: json["episode_count"] ?? 0,
        id: json["id"] ?? 0,
        name: json["name"] ?? "Unknown",
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"] ?? 0,
        voteAverage: (json["vote_average"] as num?)?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate?.toIso8601String(),
        "episode_count": episodeCount,
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
        "vote_average": voteAverage,
      };
}
