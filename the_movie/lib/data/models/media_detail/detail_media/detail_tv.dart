import 'package:easy_localization/easy_localization.dart';
import 'package:the_movie/core/utils/formatRuntime.dart';
import 'package:the_movie/core/utils/safe_null.dart';
import 'package:the_movie/data/models/media_detail/creator.dart';
import 'package:the_movie/data/models/media_detail/detail_media/detail_meida.dart';
import 'package:the_movie/data/models/media_detail/episode.dart';
import 'package:the_movie/data/models/media_detail/genre.dart';
import 'package:the_movie/data/models/media_detail/network.dart';
import 'package:the_movie/data/models/media_detail/season.dart';

class DetailTv extends DetailMedia {
  final List<Creator>? createdBy;
  final List<int>? episodeRunTime;
  final DateTime? firstAirDate;
  final bool? inProduction;
  final DateTime? lastAirDate;
  final Episode? lastEpisodeToAir;
  final String? name;
  final Episode? nextEpisodeToAir;
  final List<Network>? networks;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final String? originalName;
  final List<Season>? seasons;
  final String? type;

  DetailTv({
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
    this.createdBy,
    this.episodeRunTime,
    this.firstAirDate,
    this.inProduction,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    this.networks,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originalName,
    this.seasons,
    this.type,
  });

  factory DetailTv.fromJson(Map<String, dynamic> json) => DetailTv(
        adult: SafeNull.checkBool(json["adult"]),
        backdropPath: SafeNull.checkString(json["backdrop_path"]),
        createdBy: json["created_by"] != null
            ? List<Creator>.from(
                json["created_by"].map((x) => Creator.fromJson(x)))
            : null,
        episodeRunTime: json["episode_run_time"] != null
            ? List<int>.from(json["episode_run_time"])
            : null,
        firstAirDate: SafeNull.checkDateTime(json["first_air_date"]),
        genres: json["genres"] != null
            ? List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x)))
            : null,
        homepage: SafeNull.checkString(json["homepage"]),
        id: SafeNull.checkInt(json["id"]),
        inProduction: SafeNull.checkBool(json["in_production"]),
        lastAirDate: SafeNull.checkDateTime(json["last_air_date"]),
        lastEpisodeToAir: json["last_episode_to_air"] != null
            ? Episode.fromJson(json["last_episode_to_air"])
            : null,
        name: SafeNull.checkString(json["name"]),
        nextEpisodeToAir: json["next_episode_to_air"] != null
            ? Episode.fromJson(json["next_episode_to_air"])
            : null,
        networks: json["networks"] != null
            ? List<Network>.from(
                json["networks"].map((x) => Network.fromJson(x)))
            : null,
        numberOfEpisodes: SafeNull.checkInt(json["number_of_episodes"]),
        numberOfSeasons: SafeNull.checkInt(json["number_of_seasons"]),
        originCountry: json["origin_country"] != null
            ? List<String>.from(json["origin_country"])
            : null,
        originalLanguage: SafeNull.checkString(json["original_language"]),
        originalName: SafeNull.checkString(json["original_name"]),
        overview: SafeNull.checkString(json["overview"]),
        popularity: SafeNull.checkDouble(json["popularity"]),
        posterPath: SafeNull.checkString(json["poster_path"]),
        seasons: json["seasons"] != null
            ? List<Season>.from(json["seasons"].map((x) => Season.fromJson(x)))
            : null,
        status: SafeNull.checkString(json["status"]),
        tagline: SafeNull.checkString(json["tagline"]),
        type: SafeNull.checkString(json["type"]),
        voteAverage: SafeNull.checkDouble(json["vote_average"]),
        voteCount: SafeNull.checkInt(json["vote_count"]),
      );

  @override
  String get genreText => genres?.map((genre) => genre.name).join(', ') ?? '';

  @override
  String get releaseDateText => firstAirDate != null
      ? DateFormat('MM/dd/yyyy').format(firstAirDate!)
      : "N/A";

  @override
  String get originText => originCountry?.join(', ') ?? '';

  @override
  String get runtimeText => formatRuntime(numberOfEpisodes ?? 0);

  @override
  DateTime get releaseDayMedia => firstAirDate ?? DateTime.now();

  @override
  String get titleName => name ?? '';

  @override
  bool isMovie() {
    return false;
  }
}
