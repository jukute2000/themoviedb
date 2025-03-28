import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/auth/bloc/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void emailChanged(String value) {
    emit(state.copyWith(
      email: value,
      isValid: _validateForm(value, state.password),
    ));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(
      password: value,
      isValid: _validateForm(state.email, value),
    ));
  }

  bool _validateForm(String email, String password) {
    return email.isNotEmpty && password.isNotEmpty && password.length >= 6;
  }
}
