import 'package:the_movie/data/models/auth/firebase_auth_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final FirebaseAuthModel user;
  AuthSuccess(this.user);
}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
}
