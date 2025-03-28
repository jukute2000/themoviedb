import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_movie/core/configs/assets/app_strings.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/data/controller/api_tmdb_controller.dart';
import 'package:the_movie/presentation/auth/screen/login_screen.dart';

abstract class AuthRepository {
  Future<void> loginUser(String username, String password);
  Future<bool> isLoggedIn();
  Future<void> logOut(context);
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

      final String tokenExpried = requestTokenMap["expires_at"];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppStrings.tokenExpried, tokenExpried);

      final requestToken = requestTokenMap["request_token"];
      // tạo model RequestToken , Session

      if (requestToken == null) return false;
      final session =
          await tmdbWithCustomLogs.v3.auth.createSession(requestToken);
      final String sessionID = session["session_id"];
      await prefs.setString(AppStrings.sessionId, sessionID);
      // final pro = await tmdbWithCustomLogs.v3.account.getDetails(sessionID);
      return true;
    } catch (e) {
      // print(e);
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
      DateTime tokenExpired =
          DateTime.parse(prefs.getString(AppStrings.tokenExpried)!);
      if (sessionId == null || (tokenExpired.isBefore(now))) {
        return false;
      } else {
        // final pro = await tmdbWithCustomLogs.v3.account.getDetails(sessionId!);
        // C2: Bắt lỗi khi lấy thông tin chi tiết
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> logOut(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppStrings.sessionId);
    await prefs.remove(AppStrings.tokenExpried);
    AppNavigator.pushAndRemove(context, const LoginScreen());
  }
}
