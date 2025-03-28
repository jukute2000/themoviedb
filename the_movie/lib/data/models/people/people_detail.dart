import 'package:the_movie/core/utils/safe_null.dart';

class PeopleDetail {
  bool? adult;
  List<String>? alsoKnownAs;
  String? biography;
  DateTime? birthday;
  DateTime? deathday;
  int? gender;
  String? homepage;
  int? id;

  String? imdbId;
  String? knownForDepartment;
  String? name;
  String? placeOfBirth;

  double? popularity;
  String? profilePath;

  PeopleDetail({
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

  factory PeopleDetail.fromJson(Map<String, dynamic> json) => PeopleDetail(
        adult: SafeNull.checkBool(json["adult"]),
        alsoKnownAs: json["also_known_as"] != null
            ? List<String>.from(json["also_known_as"].map((x) => x))
            : null,
        biography: SafeNull.checkString(json["biography"]),
        birthday: SafeNull.checkDateTime(json["birthday"]),
        deathday: SafeNull.checkDateTime(json["deathday"]),
        gender: SafeNull.checkInt(json["gender"]),
        homepage: SafeNull.checkString(json["homepage"]),
        id: SafeNull.checkInt(json["id"]),
        imdbId: SafeNull.checkString(json["imdb_id"]),
        knownForDepartment: SafeNull.checkString(json["known_for_department"]),
        name: SafeNull.checkString(json["name"]),
        placeOfBirth: SafeNull.checkString(json["place_of_birth"]),
        popularity: SafeNull.checkDouble(json["popularity"]),
        profilePath: SafeNull.checkString(json["profile_path"]),
      );
}
