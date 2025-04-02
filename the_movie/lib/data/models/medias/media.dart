abstract class Media {
  String? backdropPath;
  int? id;
  String? overview;
  String? mediaType;
  String? posterPath;
  bool? adult;
  String? charater;
  double? popularity;
  double? voteAverage;
  int? voteCount;
  String? originalLanguage;
  String? character;

  Media(
      {required this.id,
      required this.charater,
      required this.overview,
      required this.mediaType,
      required this.posterPath,
      required this.adult,
      required this.popularity,
      required this.voteAverage,
      required this.voteCount,
      required this.originalLanguage,
      required this.backdropPath});

  String getTitle();
  DateTime? getReleaseDate();
  String getOriginalTitle();

  String getYear();

  bool isMovie();

  String roundVoteAverage() {
    return "${(voteAverage! * 10).round()}%";
  }

  bool goodMedia() {
    return (voteAverage! >= 7.5);
  }
}
