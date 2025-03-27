import 'package:the_movie/core/utils/safe_null.dart';

class Credit {
  bool? adult;
  int? gender;
  int? id;
  Department? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int? castId;
  String? character;
  String? creditId;
  int? order;

  Credit({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    this.castId,
    this.character,
    required this.creditId,
    this.order,
  });

  factory Credit.fromJson(Map<String, dynamic> json) => Credit(
        adult: SafeNull.checkBool(json["adult"]),
        gender: SafeNull.checkInt(json["gender"]),
        id: SafeNull.checkInt(json["id"]),
        knownForDepartment: departmentValues.map[json["known_for_department"]],
        name: SafeNull.checkString(json["name"]),
        originalName: SafeNull.checkString(json["original_name"]),
        popularity: SafeNull.checkDouble(json["popularity"]),
        profilePath: SafeNull.checkString(json["profile_path"]),
        castId: SafeNull.checkInt(json["cast_id"]),
        character: SafeNull.checkString(json["character"]),
        creditId: SafeNull.checkString(json["credit_id"]),
        order: SafeNull.checkInt(json["order"]),
      );
}

/*
map: Ánh xạ từ chuỗi → Enum (Ví dụ: "Acting" → Department.ACTING).
reverseMap: Ánh xạ từ Enum → Chuỗi (Ví dụ: Department.ACTING → "Acting").
 */
enum Department {
  ACTING,
  ART,
  CAMERA,
  COSTUME_MAKE_UP,
  CREW,
  DIRECTING,
  EDITING,
  LIGHTING,
  PRODUCTION,
  SOUND,
  VISUAL_EFFECTS,
  WRITING
}

class EnumValues<T> {
  final Map<String, T> map;
  late final Map<T, String> reverseMap;

  EnumValues(this.map) {
    reverseMap = map.map((k, v) => MapEntry(v, k));
  }
}

final departmentValues = EnumValues({
  "Acting": Department.ACTING,
  "Art": Department.ART,
  "Camera": Department.CAMERA,
  "Costume & Make-Up": Department.COSTUME_MAKE_UP,
  "Crew": Department.CREW,
  "Directing": Department.DIRECTING,
  "Editing": Department.EDITING,
  "Lighting": Department.LIGHTING,
  "Production": Department.PRODUCTION,
  "Sound": Department.SOUND,
  "Visual Effects": Department.VISUAL_EFFECTS,
  "Writing": Department.WRITING
});
