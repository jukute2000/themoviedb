abstract class Media {
  String backdropPath;
  int id;
  String overview;
  String mediaType;
  String posterPath;
  bool adult;
  double popularity;
  double voteAverage;
  int voteCount;
  String originalLanguage;

  Media(
      {required this.id,
      required this.overview,
      required this.mediaType,
      required this.posterPath,
      required this.adult,
      required this.popularity,
      required this.voteAverage,
      required this.voteCount,
      required this.originalLanguage,
      required this.backdropPath});


  factory Media.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError('Must be implemented by subclasses');
  }
}
