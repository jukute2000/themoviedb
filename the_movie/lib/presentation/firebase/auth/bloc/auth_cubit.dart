import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/models/auth/firebase_auth_model.dart';
import 'package:the_movie/data/repositories/chat/account_chat_repository.dart';
import 'package:the_movie/presentation/firebase/auth/bloc/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> signIn({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(AuthLoading());

    try {
      final FirebaseAuthModel user =
          await AccountChatRepositoryImpl.instance.signInAccount(
        email,
        password,
        name,
      );

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    Future.delayed(const Duration(seconds: 3), () {});
    try {
      final FirebaseAuthModel user =
          await AccountChatRepositoryImpl.instance.loginAccount(
        email,
        password,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
