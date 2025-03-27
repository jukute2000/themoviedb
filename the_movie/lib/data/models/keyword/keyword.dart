import 'package:the_movie/core/utils/safe_null.dart';

class Keyword {
  int? id;
  String? name;
  Keyword({required this.id, required this.name});

  @override
  factory Keyword.fromJson(Map<String, dynamic> json) => Keyword(
        id: SafeNull.checkInt(json["id"]),
        name: SafeNull.checkString(json["name"]),
      );
}
