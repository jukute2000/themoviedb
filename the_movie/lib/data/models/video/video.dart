import 'package:the_movie/core/utils/safe_null.dart';

class Video {
  String? iso6391;
  String? iso31661;
  String? name;
  String? key;
  String? site;
  int? size;
  String? type;
  bool? official;
  DateTime? publishedAt;
  String? id;

  Video({
    this.iso6391,
    this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        iso6391: SafeNull.checkString(json["iso_639_1"]),
        iso31661: SafeNull.checkString(json["iso_3166_1"]),
        name: SafeNull.checkString(json["name"]),
        key: SafeNull.checkString(json["key"]),
        site: SafeNull.checkString(json["site"]),
        size: SafeNull.checkInt(json["size"]),
        type: SafeNull.checkString(json["type"]),
        official: SafeNull.checkBool(json["official"]),
        publishedAt: SafeNull.checkDateTime(json["published_at"]),
        id: SafeNull.checkString(json["id"]),
      );
}
