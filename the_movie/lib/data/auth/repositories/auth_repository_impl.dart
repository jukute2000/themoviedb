import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_movie/core/constants/strings_manager.dart';
import 'package:the_movie/initial/tmdb_initializer.dart';
import 'package:the_movie/data/datasources/api_tmdb_controller.dart';

abstract class AuthRepository {
  Future<void> loginUser(String username, String password);
  Future<bool> isLoggedIn();
  Future<void> logOut();
}

class AuthRepositoryImpl implements AuthRepository {
  static final AuthRepositoryImpl _instance = AuthRepositoryImpl._internal();

  var tmdbWithCustomLogs = ApiTmdbController.getInstance().tmdb;
  AuthRepositoryImpl._internal();

  static AuthRepositoryImpl get instance => _instance;

  @override
  Future<bool> loginUser(String username, String password) async {
    try {
      final requestToken = await tmdbWithCustomLogs.v3.auth
          .createSessionWithLogin(username, password);

      final String tokenExpried = requestToken["expires_at"];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(StringsManager.tokenExpried, tokenExpried);

      final request_token = requestToken["request_token"];

      if (request_token == null) return false;
      final session =
          await tmdbWithCustomLogs.v3.auth.createSession(request_token);
      final String sessionID = session["session_id"];
      await prefs.setString(StringsManager.sessionId, sessionID);
      final pro = await tmdbWithCustomLogs.v3.account.getDetails(sessionID);
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
      var sessionId = prefs.getString(StringsManager.sessionId);
      // C1: Check thời gian hết hạn của token
      DateTime now = DateTime.now();
      DateTime token_expired =
          DateTime.parse(prefs.getString(StringsManager.tokenExpried)!);
      if (sessionId == null && (token_expired.isBefore(now))) {
        return false;
      } else {
        final pro = await tmdbWithCustomLogs.v3.account.getDetails(sessionId!);
        // C2: Bắt lỗi khi lấy thông tin chi tiết
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(StringsManager.sessionId);
  }
}
