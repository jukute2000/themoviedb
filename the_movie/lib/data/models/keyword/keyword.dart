class Keyword {
  int id;
  String? name;
  Keyword({required this.id, required this.name});

  @override
  factory Keyword.fromJson(Map<String, dynamic> json) =>
      Keyword(id: json["id"], name: json["name"] ?? "");
}
