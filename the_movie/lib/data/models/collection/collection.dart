class Collection {
  bool adult;
  String? backdropPath;
  int id;
  String name;
  String? originalLanguage;
  String? posterPath;

  Collection({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.name,
    required this.originalLanguage,
    required this.posterPath,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"],
        id: json["id"],
        name: json["name"],
        originalLanguage: json["original_language"],
        posterPath: json["poster_path"],
      );
}
