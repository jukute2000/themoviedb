import 'package:the_movie/core/utils/safe_null.dart';

class Network {
  final int? id;
  final String? logoPath;
  final String? name;
  final String? originCountry;

  Network({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory Network.fromJson(Map<String, dynamic> json) => Network(
        id: SafeNull.checkInt(json["id"]),
        logoPath: SafeNull.checkString(json["logo_path"]),
        name: SafeNull.checkString(json["name"]),
        originCountry: SafeNull.checkString(json["origin_country"]),
      );
}
