import 'package:the_movie/core/utils/safe_null.dart';

class KnowFor {
  int? id;
  String? name;
  String? mediaType;

  KnowFor({required this.id, required this.name, required this.mediaType});

  factory KnowFor.fromJson(Map<String, dynamic> json) {
    String newMediaType = json["media_type"];
    return KnowFor(
      id: SafeNull.checkInt(json["id"]),
      name: newMediaType != ""
          ? newMediaType == "movie"
              ? SafeNull.checkString(json["title"])
              : SafeNull.checkString(json["name"])
          : null,
      mediaType: newMediaType,
    );
  }
}
