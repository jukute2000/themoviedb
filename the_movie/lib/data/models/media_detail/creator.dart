class Creator {
  final int id;
  final String creditId;
  final String name;
  final String originalName;
  final int gender;
  final String? profilePath;

  Creator({
    required this.id,
    required this.creditId,
    required this.name,
    required this.originalName,
    required this.gender,
    this.profilePath,
  });

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
        id: json["id"] ?? 0,
        creditId: json["credit_id"] ?? "",
        name: json["name"] ?? "Unknown",
        originalName: json["original_name"] ?? "Unknown",
        gender: json["gender"] ?? 0,
        profilePath: json["profile_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "credit_id": creditId,
        "name": name,
        "original_name": originalName,
        "gender": gender,
        "profile_path": profilePath,
      };
}
