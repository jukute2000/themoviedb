class KnowFor {
  int id;
  String name;
  String mediaType;

  KnowFor({required this.id, required this.name, required this.mediaType});

  factory KnowFor.fromJson(Map<String, dynamic> json) {
    String newMediaType = json["media_type"];
    return KnowFor(
      id: json["id"],
      name: newMediaType == "movie" ? json["title"] : json["name"] ?? "",
      mediaType: newMediaType,
    );
  }
}
