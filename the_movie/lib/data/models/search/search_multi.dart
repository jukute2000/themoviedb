class SearchMulti {
  String name;
  String? originalName;
  String mediaType;
  SearchMulti(
      {required this.name,
      required this.mediaType,
      required this.originalName});

  factory SearchMulti.formJson(Map<String, dynamic> json) {
    String newMediaType = json["media_type"];
    return SearchMulti(
        name:
            newMediaType == "movie" ? json["title"] ?? "" : json["name"] ?? "",
        originalName: newMediaType != "person"
            ? newMediaType == "tv"
                ? json["original_name"]
                : json["original_title"]
            : null,
        mediaType: newMediaType);
  }
}
