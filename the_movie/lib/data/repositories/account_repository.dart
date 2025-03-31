
abstract class AuthRepository {
  Future<void> loginUser(String username, String password);
  Future<bool> isLoggedIn();
  Future<void> checkIsLoggedIn(context);
  Future<void> logOut(context);
}
