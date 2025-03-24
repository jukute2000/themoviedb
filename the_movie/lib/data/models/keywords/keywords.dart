class Keywords {
  int? id;
  String? name;
  Keywords({required this.id, required this.name});

  @override
  factory Keywords.fromJson(Map<String, dynamic> json) =>
      Keywords(id: json["id"] ?? 0, name: json["name"] ?? "");
}
