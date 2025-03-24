import 'package:the_movie/data/datasources/api_tmdb_controller.dart';
import 'package:the_movie/data/models/keywords/keywords.dart';
import 'package:the_movie/data/models/media_detail/detail_movie.dart';
import 'package:the_movie/data/models/media_detail/detail_tv.dart';
import '../models/credits/credit.dart';
import '../models/medias/movie.dart';
import '../models/medias/tv.dart';

class MediaDetailDatasoure {
  Future<DetailMovie> getMovieDetail(int id) async {
    Map<String, dynamic> result = await ApiTmdbController.getInstance()
        .tmdb
        .v3
        .movies
        .getDetails(id) as Map<String, dynamic>;
    return DetailMovie.fromJson(result);
  }

  Future<DetailTv> getTVDetail(int id) async {
    Map<String, dynamic> result = await ApiTmdbController.getInstance()
        .tmdb
        .v3
        .tv
        .getDetails(id) as Map<String, dynamic>;

    return DetailTv.fromJson(result);
  }

  Future<List<Movie>> getMovieRecommendations(int id) async {
    Map<String, dynamic> result = await ApiTmdbController.getInstance()
        .tmdb
        .v3
        .movies
        .getRecommended(id) as Map<String, dynamic>;
    List results = result['results'];
    return results.map((json) => Movie.fromJson(json)).toList();
  }

  Future<List<TiVi>> getTvRecommendations(int id) async {
    Map<String, dynamic> result = await ApiTmdbController.getInstance()
        .tmdb
        .v3
        .tv
        .getRecommendations(id) as Map<String, dynamic>;
    List results = result['results'];
    return results.map((json) => TiVi.fromJson(json)).toList();
  }

  Future<List<Credit>> getCredits({required int id, required isMovie}) async {
    Map<String, dynamic> result = {};
    if (isMovie) {
      result = await ApiTmdbController.getInstance()
          .tmdb
          .v3
          .movies
          .getCredits(id) as Map<String, dynamic>;
    } else {
      result = await ApiTmdbController.getInstance().tmdb.v3.tv.getCredits(id)
          as Map<String, dynamic>;
    }
    List results = result['cast'];
    return results.map((json) => Credit.fromJson(json)).toList();
  }

  Future<List<Keywords>> getKeywords(
      {required int id, required isMovie}) async {
    Map<String, dynamic> result = {};
    List results = [];
    if (isMovie) {
      result = await ApiTmdbController.getInstance()
          .tmdb
          .v3
          .movies
          .getKeywords(id) as Map<String, dynamic>;
      results = result['keywords'];
    } else {
      result = await ApiTmdbController.getInstance().tmdb.v3.tv.getKeywords(id)
          as Map<String, dynamic>;
      results = result['results'];
    }
    return results.map((json) => Keywords.fromJson(json)).toList();
  }
}
