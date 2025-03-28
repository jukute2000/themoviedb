import 'package:the_movie/core/utils/safe_null.dart';

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
        name: SafeNull.checkString(json["name"]),
        username: SafeNull.checkString(json["username"]),
        avatarPath: SafeNull.checkString(json["avatar_path"]),
        rating: SafeNull.checkDouble(json["rating"]),
      );
}
