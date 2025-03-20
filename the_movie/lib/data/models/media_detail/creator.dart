class Creator {
  int id;
  String creditId;
  String name;
  String originalName;
  int gender;
  String? profilePath;

  Creator({
    required this.id,
    required this.creditId,
    required this.name,
    required this.originalName,
    required this.gender,
    required this.profilePath,
  });

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
    id: json["id"],
    creditId: json["credit_id"],
    name: json["name"],
    originalName: json["original_name"],
    gender: json["gender"],
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