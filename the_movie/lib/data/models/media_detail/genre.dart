import 'package:the_movie/core/utils/safe_null.dart';

class Genre {
  final int? id;
  final String? name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: SafeNull.checkInt(json["id"]),
        name: SafeNull.checkString(json["name"]),
      );
}
