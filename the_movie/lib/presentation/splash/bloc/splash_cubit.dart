import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/repositories/auth_repository.dart';
import 'package:the_movie/presentation/splash/bloc/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(DisplaySplash());

  void appStarted() async {
    var isLoggedIn = await AuthRepositoryImpl.instance.isLoggedIn();
    var checkUpdate = await AuthRepositoryImpl.instance.checkUpdate();
    if (isLoggedIn == true && checkUpdate == false) {
      emit(Authenticated());
    } else if (isLoggedIn == true && checkUpdate == true) {
      await AuthRepositoryImpl.instance.logOut();
      emit(UnAuthenticated(checkUpdate: checkUpdate));
    } else {
      emit(UnAuthenticated(checkUpdate: checkUpdate));
    }
  }
}
