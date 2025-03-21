import 'package:the_movie/data/models/media_detail/season.dart';

import 'creator.dart';
import 'episode.dart';
import 'genre.dart';
import 'network.dart';

class DetailTv {
  final bool adult;
  final String? backdropPath;
  final List<Creator>? createdBy;
  final List<int>? episodeRunTime;
  final DateTime? firstAirDate;
  final List<Genre>? genres;
  final String? homepage;
  final int id;
  final bool? inProduction;
  final List<String>? languages;
  final DateTime? lastAirDate;
  final Episode? lastEpisodeToAir;
  final String? name;
  final Episode? nextEpisodeToAir;
  final List<Network>? networks;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<Season>? seasons;
  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;

  DetailTv({
    required this.adult,
    this.backdropPath,
    this.createdBy,
    this.episodeRunTime,
    this.firstAirDate,
    this.genres,
    this.homepage,
    required this.id,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    this.networks,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.seasons,
    this.status,
    this.tagline,
    this.type,
    this.voteAverage,
    this.voteCount,
  });

  factory DetailTv.fromJson(Map<String, dynamic> json) => DetailTv(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"],
        createdBy: json["created_by"] != null
            ? List<Creator>.from(
                json["created_by"].map((x) => Creator.fromJson(x)))
            : null,
        episodeRunTime: json["episode_run_time"] != null
            ? List<int>.from(json["episode_run_time"])
            : null,
        firstAirDate: json["first_air_date"] != null
            ? DateTime.parse(json["first_air_date"])
            : null,
        genres: json["genres"] != null
            ? List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x)))
            : null,
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: json["languages"] != null
            ? List<String>.from(json["languages"])
            : null,
        lastAirDate: json["last_air_date"] != null
            ? DateTime.parse(json["last_air_date"])
            : null,
        lastEpisodeToAir: json["last_episode_to_air"] != null
            ? Episode.fromJson(json["last_episode_to_air"])
            : null,
        name: json["name"],
        nextEpisodeToAir: json["next_episode_to_air"] != null
            ? Episode.fromJson(json["next_episode_to_air"])
            : null,
        networks: json["networks"] != null
            ? List<Network>.from(
                json["networks"].map((x) => Network.fromJson(x)))
            : null,
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: json["origin_country"] != null
            ? List<String>.from(json["origin_country"])
            : null,
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: (json["popularity"] != null)
            ? (json["popularity"] as num).toDouble()
            : null,
        posterPath: json["poster_path"],
        seasons: json["seasons"] != null
            ? List<Season>.from(json["seasons"].map((x) => Season.fromJson(x)))
            : null,
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: (json["vote_average"] != null)
            ? (json["vote_average"] as num).toDouble()
            : null,
        voteCount: json["vote_count"],
      );
}
