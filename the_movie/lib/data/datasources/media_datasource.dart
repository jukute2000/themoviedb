import 'package:the_movie/data/datasources/api_tmdb_controller.dart';

import '../models/medias/media.dart';
import '../models/medias/movie.dart';
import '../models/medias/tv.dart';

class MediaDatasource {
  Media getMediaFromJson(Map<String, dynamic> json) {
    if (json['media_type'] == 'movie') {
      return Movie.fromJson(json);
    } else {
      return TiVi.fromJson(json);
    }
  }

  Future<List<Media>> getMediaTrending(int page) async {
    Map result = await ApiTmdbController.getInstance()
        .tmdb
        .v3
        .trending
        .getTrending(page: page);
    List results = result['results'];
    return results.map((json) => getMediaFromJson(json)).toList();
  }

  Future<List<Movie>> getMediaPopular() async {
    Map result =
        await ApiTmdbController.getInstance().tmdb.v3.movies.getPopular();
    List results = result['results'];
    return results.map((json) => Movie.fromJson(json)).toList();
  }
}
