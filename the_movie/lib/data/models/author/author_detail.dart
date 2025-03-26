class AuthorDetail {
  String? name;
  String? username;
  String? avatarPath;
  double? rating;

  AuthorDetail({
    required this.name,
    required this.username,
    required this.avatarPath,
    required this.rating,
  });

  factory AuthorDetail.fromJson(Map<String, dynamic> json) => AuthorDetail(
        name: json["name"],
        username: json["username"],
        avatarPath: json["avatar_path"],
        rating: json["rating"] is double
            ? json["rating"]
            : json["rating"] is String
                ? double.tryParse(json["rating"])
                : null,
      );
}
