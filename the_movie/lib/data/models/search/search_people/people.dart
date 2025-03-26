import 'package:the_movie/data/models/search/search_people/know_for.dart';

class People {
  int id;
  String name;
  String? profilePath;
  String knownForDepartment;
  List<KnowFor> knowFors;

  People({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.knownForDepartment,
    required this.knowFors,
  });

  factory People.fromJson(Map<String, dynamic> json) => People(
      id: json["id"],
      name: json["name"],
      profilePath: json["profile_path"] ?? "",
      knownForDepartment: json["known_for_department"],
      knowFors: List<KnowFor>.from(
          json["known_for"].map((json) => KnowFor.fromJson(json))));
}
