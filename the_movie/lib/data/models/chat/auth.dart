import 'package:the_movie/core/utils/safe_null.dart';

class Authentication {
  String? id;
  String? name;
  Authentication({
    required this.id,
    required this.name,
  });

  factory Authentication.fromJson(Map<String, dynamic> json) {
    return Authentication(
      id: SafeNull.checkString(json["id"]),
      name: SafeNull.checkString(json["name"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }

  String firstCharName() {
    return name?.substring(0, 1).toUpperCase() ?? "Unknow";
  }
}
