import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/repositories/auth_repository.dart';
import 'package:the_movie/presentation/splash/bloc/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(DisplaySplash());

  void appStarted() async {
    await Future.delayed(const Duration(seconds: 3));
    var isLoggedIn = AuthRepositoryImpl.instance.isLoggedIn();
    if (await isLoggedIn) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }
}
