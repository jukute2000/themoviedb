import 'package:the_movie/core/utils/safe_null.dart';

class SearchMulti {
  String? name;
  String? originalName;
  String? mediaType;
  SearchMulti(
      {required this.name,
      required this.mediaType,
      required this.originalName});

  factory SearchMulti.formJson(Map<String, dynamic> json) {
    String newMediaType = json["media_type"];
    return SearchMulti(
        name: newMediaType == "movie"
            ? SafeNull.checkString(json["title"])
            : SafeNull.checkString(json["name"]),
        originalName: newMediaType != "person"
            ? newMediaType == "tv"
                ? SafeNull.checkString(json["original_name"])
                : SafeNull.checkString(json["original_title"])
            : null,
        mediaType: SafeNull.checkString(newMediaType));
  }
}
