import 'package:the_movie/core/utils/safe_null.dart';

class ReleaseDates {
  String? iso31661;
  List<ReleaseDate>? releaseDates;

  ReleaseDates({required this.iso31661, required this.releaseDates});

  factory ReleaseDates.fromJson(Map<String, dynamic> json) {
    if (json["iso_3166_1"] == "VN" || json["iso_3166_1"] == "US") {
      return ReleaseDates(
        iso31661: json["iso_3166_1"],
        releaseDates: (json["release_dates"] as List<dynamic>?)
            ?.map((x) => ReleaseDate.fromJson(x))
            .toList(),
      );
    } else {
      return ReleaseDates(iso31661: null, releaseDates: null);
    }
  }
}

class ReleaseDate {
  String? certification;
  List<dynamic>? descriptors;
  String? iso6391;
  String? note;
  String? releaseDate;
  int? type;

  ReleaseDate({
    required this.certification,
    required this.descriptors,
    required this.iso6391,
    required this.note,
    required this.releaseDate,
    required this.type,
  });

  factory ReleaseDate.fromJson(Map<String, dynamic> json) => ReleaseDate(
        certification: SafeNull.checkString(json["certification"]),
        descriptors: json["descriptors"],
        iso6391: SafeNull.checkString(json["iso_639_1"]),
        note: SafeNull.checkString(json["note"]),
        releaseDate: json["release_date"], //luu y
        type: SafeNull.checkInt(json["type"]),
      );
}
