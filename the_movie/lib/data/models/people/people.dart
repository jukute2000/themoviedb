import 'package:the_movie/data/models/people/know_for.dart';

class People {
  bool adult;
  int id;
  String name;
  String? profilePath;
  String knownForDepartment;
  List<KnowFor> knowFors;
  double? popularity;
  People({
    required this.adult,
    required this.id,
    required this.name,
    required this.profilePath,
    required this.knownForDepartment,
    required this.knowFors,
    required this.popularity,
  });

  factory People.fromJson(Map<String, dynamic> json) => People(
      adult: json["adult"] is bool
          ? json["adult"]
          : json["adult"] is String
              ? bool.parse(json["adult"])
              : false,
      id: json["id"] is int
          ? json["id"]
          : json["id"] != null && json["id"] is String
              ? int.parse(json["id"])
              : 0,
      name: json["name"],
      profilePath: json["profile_path"] ?? "",
      knownForDepartment: json["known_for_department"],
      popularity: json["popularity"] is double
          ? json["popularity"]
          : json["popularity"] is String
              ? double.tryParse(json["popularity"])
              : 0.0,
      knowFors: List<KnowFor>.from(
          json["known_for"].map((json) => KnowFor.fromJson(json))));
}
