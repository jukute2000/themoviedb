import 'package:the_movie/core/utils/safe_null.dart';
import 'package:the_movie/data/models/people/know_for.dart';

class People {
  bool? adult;
  int? id;
  String? name;
  String? profilePath;
  String? knownForDepartment;
  List<KnowFor>? knowFors;
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
        adult: SafeNull.checkBool(json["adult"]),
        id: SafeNull.checkInt(json["id"]),
        name: SafeNull.checkString(json["name"]),
        profilePath: SafeNull.checkString(json["profile_path"]),
        knownForDepartment: SafeNull.checkString(json["known_for_department"]),
        popularity: SafeNull.checkDouble(json["popularity"]),
        knowFors: json["known_for"] != null
            ? List<KnowFor>.from(
                json["known_for"].map((json) => KnowFor.fromJson(json)))
            : null,
      );
}
