class PeopleDetail {
  bool adult;
  List<String>? alsoKnownAs;
  String biography;
  DateTime? birthday;
  DateTime? deathday;
  int gender;
  String? homepage;
  int id;
  String? imdbId;
  String? knownForDepartment;
  String? name;
  String? placeOfBirth;
  double popularity;
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
        adult: json["adult"] is bool
            ? json["adult"]
            : json["adult"] is String
                ? bool.parse(json["adult"])
                : null,
        alsoKnownAs: List<String>.from(json["also_known_as"].map((x) => x)),
        biography: json["biography"],
        birthday: json["birthday"] != null && json["birthday"] is String
            ? DateTime.tryParse(json["birthday"])
            : null,
        deathday: json["deathday"] != null && json["deathday"] is String
            ? DateTime.tryParse(json["deathday"])
            : null,
        gender: json["gender"] is int
            ? json["gender"]
            : json["gender"] != null && json["gender"] is String
                ? int.parse(json["gender"])
                : 0,
        homepage: json["homepage"],
        id: json["id"] is int
            ? json["id"]
            : json["id"] != null && json["id"] is String
                ? int.parse(json["id"])
                : 0,
        imdbId: json["imdb_id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        placeOfBirth: json["place_of_birth"],
        popularity: json["popularity"] is double
            ? json["popularity"]
            : json["popularity"] != null && json["popularity"] is String
                ? double.parse(json["popularity"])
                : 0.0,
        profilePath: json["profile_path"],
      );
}
