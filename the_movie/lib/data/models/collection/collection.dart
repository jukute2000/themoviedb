import 'package:the_movie/core/utils/safe_null.dart';

class Collection {
  bool? adult;
  String? backdropPath;
  int? id;
  String? name;
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
        adult: SafeNull.checkBool(json["adult"]),
        backdropPath: SafeNull.checkString(json["backdrop_path"]),
        id: SafeNull.checkInt(json["id"]),
        name: SafeNull.checkString(json["name"]),
        originalLanguage: SafeNull.checkString(json["original_language"]),
        posterPath: SafeNull.checkString(json["poster_path"]),
      );
}
