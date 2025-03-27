import 'package:the_movie/core/utils/safe_null.dart';

class Creator {
  final int? id;
  final String? creditId;
  final String? name;
  final String? originalName;
  final int? gender;
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
        id: SafeNull.checkInt(json["id"]),
        creditId: SafeNull.checkString(json["credit_id"]),
        name: SafeNull.checkString(json["name"]),
        originalName: SafeNull.checkString(json["original_name"]),
        gender: SafeNull.checkInt(json["gender"]),
        profilePath: SafeNull.checkString(json["profile_path"]),
      );
}
