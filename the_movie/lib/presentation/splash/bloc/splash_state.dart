// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class SplashState {}

class DisplaySplash extends SplashState {}

class Authenticated extends SplashState {}

class UnAuthenticated extends SplashState {
  final bool checkUpdate;
  UnAuthenticated({
    required this.checkUpdate,
  });

}
