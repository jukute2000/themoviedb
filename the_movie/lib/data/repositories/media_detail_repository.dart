import 'package:the_movie/data/models/account/account_status.dart';
import 'package:the_movie/data/models/author/author.dart';
import 'package:the_movie/data/models/release_date/release_date.dart';
import 'package:the_movie/data/repositories/auth_repository.dart';

import '../controller/api_tmdb_controller.dart';
import '../models/credits/credit.dart';
import '../models/keyword/keyword.dart';
import '../models/media_detail/detail_media/detail_movie.dart';
import '../models/media_detail/detail_media/detail_tv.dart';
import '../models/medias/movie.dart';
import '../models/medias/tv.dart';
import '../models/video/video.dart';

abstract class MediaDetailRepository {
  Future<DetailMovie> getMovieDetail(int id);
  Future<DetailTv> getTVDetail(int id);
  Future<List<Movie>> getMovieRecommendations(int id);
  Future<List<TiVi>> getTvRecommendations(int id);
  Future<List<Credit>> getCredits({required int id, required bool isMovie});
  Future<List<Keyword>> getKeywords({required int id, required bool isMovie});
  Future<List<Video>> getVideos({required int id, required bool isMovie});
  Future<ReleaseDates> getReleaseDates({required int id}); //chỉ có Movie
  Future<Review> getReview({required int id, required bool isMovie});
  Future<void> rateMovie(
      {required int id, required double rateMedia, required bool isMovie});
  Future<void> deleteRate({required int id, required bool isMovie});
  Future<AccountStatus> getAccountStatus(
      {required int id, required bool isMovie});
}

class MediaDetailRepositoryImpl implements MediaDetailRepository {
  static final MediaDetailRepositoryImpl _instance =
      MediaDetailRepositoryImpl._internal();
  MediaDetailRepositoryImpl._internal();
  static MediaDetailRepositoryImpl get instance => _instance;

  @override
  Future<DetailMovie> getMovieDetail(int id) async {
    Map<String, dynamic> result = await ApiTmdbController.getInstance()
        .tmdb
        .v3
        .movies
        .getDetails(id) as Map<String, dynamic>;
    return DetailMovie.fromJson(result);
  }

  @override
  Future<DetailTv> getTVDetail(int id) async {
    Map<String, dynamic> result = await ApiTmdbController.getInstance()
        .tmdb
        .v3
        .tv
        .getDetails(id) as Map<String, dynamic>;

    return DetailTv.fromJson(result);
  }

  @override
  Future<List<Movie>> getMovieRecommendations(int id) async {
    Map<String, dynamic> result = await ApiTmdbController.getInstance()
        .tmdb
        .v3
        .movies
        .getRecommended(id) as Map<String, dynamic>;
    List results = result['results'];
    return results.map((json) => Movie.fromJson(json)).toList();
  }

  @override
  Future<List<TiVi>> getTvRecommendations(int id) async {
    Map<String, dynamic> result = await ApiTmdbController.getInstance()
        .tmdb
        .v3
        .tv
        .getRecommendations(id) as Map<String, dynamic>;
    List results = result['results'];
    return results.map((json) => TiVi.fromJson(json)).toList();
  }

  @override
  Future<List<Credit>> getCredits(
      {required int id, required bool isMovie}) async {
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

  @override
  Future<List<Keyword>> getKeywords(
      {required int id, required bool isMovie}) async {
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
    return results.map((json) => Keyword.fromJson(json)).toList();
  }

  @override
  Future<List<Video>> getVideos(
      {required int id, required bool isMovie}) async {
    Map<String, dynamic> result = {};

    if (isMovie) {
      result = await ApiTmdbController.getInstance()
          .tmdb
          .v3
          .movies
          .getVideos(id) as Map<String, dynamic>;
    } else {
      result = await ApiTmdbController.getInstance().tmdb.v3.tv.getVideos("$id")
          as Map<String, dynamic>;
    }
    List results = result["results"];
    return results.map((json) => Video.fromJson(json)).toList();
  }

  @override
  Future<ReleaseDates> getReleaseDates({required int id}) async {
    Map<String, dynamic> result = await ApiTmdbController.getInstance()
        .tmdb
        .v3
        .movies
        .getReleaseDates(id) as Map<String, dynamic>;
    List results = result["results"];
    for (var json in results) {
      ReleaseDates releaseDate = ReleaseDates.fromJson(json);
      if (releaseDate.iso31661 == "VN" || releaseDate.iso31661 == "US") {
        return releaseDate;
      }
    }
    return ReleaseDates(iso31661: "Unknown", releaseDates: []);
  }

  @override
  Future<Review> getReview({required int id, required bool isMovie}) async {
    Map<String, dynamic> result = {};
    if (isMovie) {
      result = await ApiTmdbController.getInstance()
          .tmdb
          .v3
          .movies
          .getReviews(id) as Map<String, dynamic>;
    } else {
      result = await ApiTmdbController.getInstance().tmdb.v3.tv.getReviews(id)
          as Map<String, dynamic>;
    }
    return Review.fromJson(result);
  }

  @override
  Future<void> rateMovie(
      {required int id,
      required double rateMedia,
      required bool isMovie}) async {
    String sessionId = await AuthRepositoryImpl.instance.checkIsLoggedIn();
    if (isMovie) {
      await ApiTmdbController.getInstance()
          .tmdb
          .v3
          .movies
          .rateMovie(id, rateMedia, sessionId: sessionId);
    } else {
      await ApiTmdbController.getInstance()
          .tmdb
          .v3
          .tv
          .rateTvShow(id, rateMedia, sessionId: sessionId);
    }
  }

  @override
  Future<void> deleteRate({required int id, required bool isMovie}) async {
    String sessionId = await AuthRepositoryImpl.instance.checkIsLoggedIn();
    if (isMovie) {
      await ApiTmdbController.getInstance()
          .tmdb
          .v3
          .movies
          .deleteRating(id, sessionId: sessionId);
    } else {
      await ApiTmdbController.getInstance()
          .tmdb
          .v3
          .tv
          .deleteRating(id, sessionId: sessionId);
    }
  }

  @override
  Future<AccountStatus> getAccountStatus(
      {required int id, required bool isMovie}) async {
    String sessionId = await AuthRepositoryImpl.instance.checkIsLoggedIn();
    Map<String, dynamic> result = {};
    if (isMovie) {
      result = await ApiTmdbController.getInstance()
          .tmdb
          .v3
          .movies
          .getAccountStatus(id, sessionId: sessionId) as Map<String, dynamic>;
    } else {
      result = await ApiTmdbController.getInstance()
          .tmdb
          .v3
          .tv
          .getAccountStatus(id, sessionId: sessionId) as Map<String, dynamic>;
    }

    return AccountStatus.fromJson(result);
  }
}
