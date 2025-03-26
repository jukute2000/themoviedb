class Video {
  String? iso6391;
  String? iso31661;
  String name;
  String key;
  String site;
  int size;
  String type;
  bool official;
  DateTime? publishedAt;
  String id;

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
        iso6391: json["iso_639_1"],
        iso31661: json["iso_3166_1"],
        name: json["name"] ?? "Unknown",
        key: json["key"] ?? "NoKey",
        site: json["site"] ?? "Unknown",
        size: json["size"] is int
            ? json["size"]
            : json["size"] != null
                ? int.parse(json["size"])
                : 0,
        type: json["type"] ?? "Unknown",
        official: json["official"] as bool? ?? false,
        publishedAt:
            json["published_at"] != null && json["published_at"] is String
                ? DateTime.tryParse(json["published_at"].toString())
                : null,
        id: json["id"] as String? ?? "UnknownID",
      );
}
