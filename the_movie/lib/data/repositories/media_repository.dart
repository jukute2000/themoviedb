import 'package:the_movie/data/controller/api_tmdb_controller.dart';
import 'package:the_movie/data/models/medias/media.dart';
import 'package:the_movie/data/models/medias/movie.dart';
import 'package:the_movie/data/models/medias/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

abstract class MeidaRepository {
  Future<List<Media>> getMediaTrending(int page, TimeWindow timeWindow);
  Future<List<Movie>> getMoviePopular();
}

class MediaRepositoryImpl implements MeidaRepository {
  static final MediaRepositoryImpl _instance = MediaRepositoryImpl._internal();

  MediaRepositoryImpl._internal();

  static MediaRepositoryImpl get instance => _instance;

  @override
  Future<List<Media>> getMediaTrending(int page, TimeWindow timeWindow) async {
    Map result = await ApiTmdbController.getInstance()
        .tmdb
        .v3
        .trending
        .getTrending(timeWindow: timeWindow);
    List results = result['results'];
    return results.map((json) => getMediaFromJson(json)).toList();
  }

  @override
  Future<List<Movie>> getMoviePopular() async {
    Map result =
        await ApiTmdbController.getInstance().tmdb.v3.movies.getPopular();
    List results = result['results'];
    return results.map((json) => getMovieFromJson(json)).toList();
  }

  Media getMediaFromJson(Map<String, dynamic> json) {
    if (json['media_type'] == 'movie') {
      return Movie.fromJson(json);
    } else {
      return TiVi.fromJson(json);
    }
  }

  Movie getMovieFromJson(Map<String, dynamic> json) {
    return Movie.fromJson(json);
  }

  TiVi getTiviFromJson(Map<String, dynamic> json) {
    return TiVi.fromJson(json);
  }
}
