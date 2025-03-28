import 'package:the_movie/core/utils/safe_null.dart';
import 'package:the_movie/data/models/credits/combined_credit.dart/crew.dart';
import 'package:the_movie/data/models/medias/media.dart';
import 'package:the_movie/data/models/medias/movie.dart';
import 'package:the_movie/data/models/medias/tv.dart';

class CombinedCredit {
  List<Media>? cast;
  List<Crew>? crew;
  int? id;

  CombinedCredit({
    required this.cast,
    required this.crew,
    required this.id,
  });

  static Media getMediaFromJson(Map<String, dynamic> json) {
    if (json['media_type'] == 'movie') {
      return Movie.fromJson(json);
    } else {
      return TiVi.fromJson(json);
    }
  }

  factory CombinedCredit.fromJson(Map<String, dynamic> json) => CombinedCredit(
        cast: json["cast"] != null
            ? List<Media>.from(
                json["cast"].map((x) => CombinedCredit.getMediaFromJson(x)))
            : null,
        crew: json["cast"] != null
            ? List<Crew>.from(json["crew"].map((x) => Crew.fromJson(x)))
            : null,
        id: SafeNull.checkInt(json["id"]),
      );
}
