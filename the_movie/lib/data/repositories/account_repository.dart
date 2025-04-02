import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_movie/data/controller/api_tmdb_controller.dart';
import 'package:the_movie/data/models/account/account_model.dart';
import 'package:the_movie/data/models/medias/movie.dart';
import 'package:the_movie/data/models/medias/tv.dart';
import 'package:the_movie/data/repositories/auth_repository.dart';
import 'package:the_movie/data/repositories/media_repository.dart';
import 'package:tmdb_api/tmdb_api.dart';

abstract class AccountRepository {
  Future<void> addToWatchList(int id, bool isMovie, bool isWatchList);
  Future<void> addToFavorites(int id, bool isMovie, bool isFavorites);
  Future<AccountModel> getDetails();
  Future<int> getAccountId();
  Future<List<Movie>> getMovieFavorites();
  Future<List<TiVi>> getTiviFavorites();
  
}

class AccountRepositoryImpl implements AccountRepository {
  static final AccountRepositoryImpl _instance =
      AccountRepositoryImpl._internal();
  AccountRepositoryImpl._internal();
  static AccountRepositoryImpl get instance => _instance;

  @override
  Future<void> addToWatchList(int id, bool isMovie, bool isWatchList) async {
    String sessionId = await AuthRepositoryImpl.instance.checkIsLoggedIn();
    int accountId = await AccountRepositoryImpl.instance.getAccountId();
    if (isMovie) {
      await ApiTmdbController.getInstance().tmdb.v3.account.addToWatchList(
          sessionId, accountId, id, MediaType.movie,
          shouldAdd: isWatchList);
    } else {
      await ApiTmdbController.getInstance().tmdb.v3.account.addToWatchList(
          sessionId, accountId, id, MediaType.tv,
          shouldAdd: isWatchList);
    }
  }

  @override
  Future<void> addToFavorites(int id, bool isMovie, bool isFavorites) async {
    String sessionId = await AuthRepositoryImpl.instance.checkIsLoggedIn();
    int accountId = await AccountRepositoryImpl.instance.getAccountId();
    if (isMovie) {
      await ApiTmdbController.getInstance().tmdb.v3.account.markAsFavorite(
          sessionId, accountId, id, MediaType.movie,
          isFavorite: isFavorites);
    } else {
      await ApiTmdbController.getInstance().tmdb.v3.account.markAsFavorite(
          sessionId, accountId, id, MediaType.tv,
          isFavorite: isFavorites);
    }
  }

  @override
  Future<AccountModel> getDetails() async {
    String sessionId = await AuthRepositoryImpl.instance.checkIsLoggedIn();
    Map<String, dynamic> result = {};
    result = await ApiTmdbController.getInstance()
        .tmdb
        .v3
        .account
        .getDetails(sessionId) as Map<String, dynamic>;
    return AccountModel.fromJson(result);
  }

  @override
  Future<int> getAccountId() async {
    final prefs = await SharedPreferences.getInstance();
    String? stringAccountId = prefs.getString("AccountId");
    int AccountId;
    if (stringAccountId == null) {
      String sessionId = await AuthRepositoryImpl.instance.checkIsLoggedIn();
      final result = await ApiTmdbController.getInstance()
          .tmdb
          .v3
          .account
          .getDetails(sessionId) as Map<String, dynamic>;
      AccountId = result["id"];
      await prefs.setString("AccountId", AccountId.toString());
    } else {
      AccountId = int.parse(stringAccountId);
    }

    return AccountId;
  }

  @override
  Future<List<Movie>> getMovieFavorites() async {
    String sessionId = await AuthRepositoryImpl.instance.checkIsLoggedIn();
    int accountId = await AccountRepositoryImpl.instance.getAccountId();
    Map result = await ApiTmdbController.getInstance()
        .tmdb
        .v3
        .account
        .getFavoriteMovies(sessionId, accountId);
    List results = result['results'];
    return results
        .map((json) => MediaRepositoryImpl.instance.getMovieFromJson(json))
        .toList();
  }

  @override
  Future<List<TiVi>> getTiviFavorites() async {
    String sessionId = await AuthRepositoryImpl.instance.checkIsLoggedIn();
    int accountId = await AccountRepositoryImpl.instance.getAccountId();
    Map result = await ApiTmdbController.getInstance()
        .tmdb
        .v3
        .account
        .getFavoriteTvShows(sessionId, accountId);
    List results = result['results'];
    return results
        .map((json) => MediaRepositoryImpl.instance.getTiviFromJson(json))
        .toList();
  }
}
