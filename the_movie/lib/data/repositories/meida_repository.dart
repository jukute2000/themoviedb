import 'package:the_movie/data/models/medias/movie.dart';
import '../controller/api_tmdb_controller.dart';
import '../models/medias/media.dart';
import '../models/medias/tv.dart';

abstract class MeidaRepository {
  Future<List<Media>> getMediaTrending(int page);
  Future<List<Movie>> getMoviePopular();
}

class MeidaRepositoryImpl implements MeidaRepository {
  static final MeidaRepositoryImpl _instance = MeidaRepositoryImpl._internal();
  MeidaRepositoryImpl._internal();
  static MeidaRepositoryImpl get intance => _instance;

  @override
  Future<List<Media>> getMediaTrending(int page) async {
    Map result = await ApiTmdbController.getInstance()
        .tmdb
        .v3
        .trending
        .getTrending(page: page);
    List results = result['results'];
    return results.map((json) => _getMediaFromJson(json)).toList();
  }

  @override
  Future<List<Movie>> getMoviePopular() async {
    Map result =
        await ApiTmdbController.getInstance().tmdb.v3.movies.getPopular();
    List results = result['results'];
    return results.map((json) => Movie.fromJson(json)).toList();
  }

  Media _getMediaFromJson(Map<String, dynamic> json) {
    if (json['media_type'] == 'movie') {
      return Movie.fromJson(json);
    } else {
      return TiVi.fromJson(json);
    }
  }
}
