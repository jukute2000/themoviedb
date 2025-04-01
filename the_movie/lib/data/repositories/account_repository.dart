import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_movie/data/controller/api_tmdb_controller.dart';
import 'package:the_movie/data/models/account/account_model.dart';
import 'package:the_movie/data/repositories/auth_repository.dart';
import 'package:tmdb_api/tmdb_api.dart';

abstract class AccountRepository {
  Future<void> addToWatchList(int id, bool isMovie, bool isWatchList);
  Future<void> addToFavorites(int id, bool isMovie, bool isFavorites);
  Future<AccountModel> getDetails();
  Future<int> getAccountId();
}

class AccountRepositoryImpl implements AccountRepository {
  static final AccountRepositoryImpl _instance =
      AccountRepositoryImpl._internal();
  AccountRepositoryImpl._internal();
  static AccountRepositoryImpl get intance => _instance;

  @override
  Future<void> addToWatchList(int id, bool isMovie, bool isWatchList) async {
    String sessionId = await AuthRepositoryImpl.instance.checkIsLoggedIn();
    int accountId = await AccountRepositoryImpl.intance.getAccountId();
    if (isMovie) {
      await ApiTmdbController.getInstance().tmdb.v3.account.addToWatchList(
          sessionId, accountId, id, MediaType.movie, isWatchList);
    } else {
      await ApiTmdbController.getInstance()
          .tmdb
          .v3
          .account
          .addToWatchList(sessionId, accountId, id, MediaType.tv, isWatchList);
    }
  }

  @override
  Future<void> addToFavorites(int id, bool isMovie, bool isFavorites) async {
    String sessionId = await AuthRepositoryImpl.instance.checkIsLoggedIn();
    int accountId = await AccountRepositoryImpl.intance.getAccountId();
    if (isMovie) {
      await ApiTmdbController.getInstance().tmdb.v3.account.markAsFavorite(
          sessionId, accountId, id, MediaType.movie, isFavorites);
    } else {
      await ApiTmdbController.getInstance()
          .tmdb
          .v3
          .account
          .markAsFavorite(sessionId, accountId, id, MediaType.tv, isFavorites);
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
      AccountId = int.parse(stringAccountId!);
    }

    return AccountId;
  }
}
