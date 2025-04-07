import 'package:the_movie/core/utils/safe_null.dart';

class RecommenedMedia {
  final int id;
  final bool isMovie;

  RecommenedMedia({required this.id, required this.isMovie});

  factory RecommenedMedia.fromJson(Map<String, dynamic> json) {
    return RecommenedMedia(
      id: SafeNull.checkInt(json['id']),
      isMovie: SafeNull.checkBool(json['isMovie']),
    );
  }
}
