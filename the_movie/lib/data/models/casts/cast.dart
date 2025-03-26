// To parse this JSON data, do
//
//     final people = peopleFromJson(jsonString);

import 'dart:convert';

Cast peopleFromJson(String str) => Cast.fromJson(json.decode(str));

String peopleToJson(Cast data) => json.encode(data.toJson());

class Cast {
  bool adult;
  List<String> alsoKnownAs;
  String biography;
  DateTime? birthday;
  DateTime? deathday;
  int gender;
  dynamic homepage;
  int id;
  String imdbId;
  String knownForDepartment;
  String name;
  String placeOfBirth;
  double popularity;
  String profilePath;

  Cast({
    required this.adult,
    required this.alsoKnownAs,
    required this.biography,
    required this.birthday,
    required this.deathday,
    required this.gender,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.knownForDepartment,
    required this.name,
    required this.placeOfBirth,
    required this.popularity,
    required this.profilePath,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"] ?? false,
        alsoKnownAs: (json["also_known_as"] as List<dynamic>?)
                ?.map((x) => x as String)
                .toList() ??
            [],
        biography: json["biography"] ?? "",
        birthday: json["birthday"] != null
            ? DateTime.tryParse(json["birthday"])
            : null,
        deathday: json["deathday"] != null
            ? DateTime.tryParse(json["deathday"])
            : null,
        gender: json["gender"] ?? 0,
        homepage: json["homepage"],
        id: json["id"] ?? 0,
        imdbId: json["imdb_id"],
        knownForDepartment: json["known_for_department"] ?? "",
        name: json["name"] ?? "Unknown",
        placeOfBirth: json["place_of_birth"],
        popularity: (json["popularity"] as num?)?.toDouble() ?? 0.0,
        profilePath: json["profile_path"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "also_known_as": List<dynamic>.from(alsoKnownAs.map((x) => x)),
        "biography": biography,
        "birthday":
            "${birthday?.year.toString().padLeft(4, '0')}-${birthday?.month.toString().padLeft(2, '0')}-${birthday?.day.toString().padLeft(2, '0')}",
        "deathday":
            "${deathday?.year.toString().padLeft(4, '0')}-${deathday?.month.toString().padLeft(2, '0')}-${deathday?.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "homepage": homepage,
        "id": id,
        "imdb_id": imdbId,
        "known_for_department": knownForDepartment,
        "name": name,
        "place_of_birth": placeOfBirth,
        "popularity": popularity,
        "profile_path": profilePath,
      };
}
