import 'package:the_movie/core/utils/safe_null.dart';

class External {
  int? id;
  String? freebaseMid;
  String? freebaseId;
  String? imdbId;
  int? tvrageId;
  String? wikidataId;
  String? facebookId;
  String? instagramId;
  String? tiktokId;
  String? twitterId;
  String? youtubeId;

  External({
    required this.id,
    required this.freebaseMid,
    required this.freebaseId,
    required this.imdbId,
    required this.tvrageId,
    required this.wikidataId,
    required this.facebookId,
    required this.instagramId,
    required this.tiktokId,
    required this.twitterId,
    required this.youtubeId,
  });

  factory External.fromJson(Map<String, dynamic> json) => External(
        id: SafeNull.checkInt(External),
        freebaseMid: SafeNull.checkString(json["freebase_mid"]),
        freebaseId: SafeNull.checkString(json["freebase_id"]),
        imdbId: SafeNull.checkString(json["imdb_id"]),
        tvrageId: SafeNull.checkInt(json["tvrage_id"]),
        wikidataId: SafeNull.checkString(json["wikidata_id"]),
        facebookId: SafeNull.checkString(json["facebook_id"]),
        instagramId: SafeNull.checkString(json["instagram_id"]),
        tiktokId: SafeNull.checkString(json["tiktok_id"]),
        twitterId: SafeNull.checkString(json["twitter_id"]),
        youtubeId: SafeNull.checkString(json["youtube_id"]),
      );
}
