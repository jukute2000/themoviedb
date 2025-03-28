import 'package:the_movie/core/utils/safe_null.dart';

class Company {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  Company(
      {required this.id,
      required this.name,
      required this.logoPath,
      required this.originCountry});

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: SafeNull.checkInt(json["order"]),
        logoPath: SafeNull.checkString(json["logo_path"]),
        name: SafeNull.checkString(json["name"]),
        originCountry: SafeNull.checkString(json["origin_country"]),
      );
}
