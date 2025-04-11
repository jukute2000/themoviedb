import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_movie/core/configs/assets/app_strings.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/data/controller/api_tmdb_controller.dart';
import 'package:the_movie/data/models/auth/request_token.dart';
import 'package:the_movie/data/models/auth/session.dart';
import 'package:the_movie/initial/remote_confic.dart';
import 'package:the_movie/presentation/splash/screen/splash_screen.dart';

abstract class AuthRepository {
  Future<void> loginUser(String username, String password);
  Future<bool> isLoggedIn();
  Future<void> checkIsLoggedIn();
  Future<void> logOut();
  Future<bool> checkUpdate();
}

class AuthRepositoryImpl implements AuthRepository {
  static final AuthRepositoryImpl _instance = AuthRepositoryImpl._internal();

  var tmdbWithCustomLogs = ApiTmdbController.getInstance().tmdb;
  AuthRepositoryImpl._internal();

  static AuthRepositoryImpl get instance => _instance;

  @override
  Future<bool> loginUser(String username, String password) async {
    try {
      final requestTokenMap = await tmdbWithCustomLogs.v3.auth
          .createSessionWithLogin(username, password);

      final requestTokenModel = RequestToken.fromJson(requestTokenMap);

      if (requestTokenModel.expiresAt == '') return false;
      if (requestTokenModel.requestToken == '') return false;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          AppStrings.tokenExpried, requestTokenModel.expiresAt);

      final sessionMap = await tmdbWithCustomLogs.v3.auth
          .createSession(requestTokenModel.requestToken);

      final sessionModel = Session.fromJson(sessionMap);
      await prefs.setString(AppStrings.sessionId, sessionModel.sessionId);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var sessionId = prefs.getString(AppStrings.sessionId);
      // C1: Check thời gian hết hạn của token
      DateTime now = DateTime.now();

      var tokenExpiredString = prefs.getString(AppStrings.tokenExpried);
      if (sessionId == null || tokenExpiredString == null) {
        return false;
      } else {
        DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss 'UTC'");
        DateTime tokenExpired = format.parseUtc(tokenExpiredString);
        if ((tokenExpired.isBefore(now))) {
          return false;
        }
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    var sessionId = prefs.getString(AppStrings.sessionId);
    await tmdbWithCustomLogs.v3.auth.deleteSession(sessionId!);
    await prefs.remove(AppStrings.sessionId);
    await prefs.remove(AppStrings.tokenExpried);
    NavigationService.navigateTo(const SplashScreen());
  }

  @override
  Future<String> checkIsLoggedIn() async {
    if (await isLoggedIn() == false) {
      await logOut();
      return '';
    } else {
      final prefs = await SharedPreferences.getInstance();
      var sessionId = prefs.getString(AppStrings.sessionId);
      return sessionId ?? '';
    }
  }

  @override
  Future<bool> checkUpdate() async {
    return await RemoteConfic.instance.getUpdate();
  }
}
