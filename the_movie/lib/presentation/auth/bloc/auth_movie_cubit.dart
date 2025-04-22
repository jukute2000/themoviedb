import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/repositories/auth_repository.dart';
import 'package:the_movie/presentation/auth/bloc/auth_movie_state.dart';

class AuthMovieCubit extends Cubit<AuthMovieState> {
  AuthMovieCubit() : super(AuthMovieInitial());

  Future<void> login({
    required String name,
    required String password,
  }) async {
    emit(AuthMovieLoading());
    try {
      final bool result =
          await AuthRepositoryImpl.instance.loginUser(name, password);
      emit(AuthMovieSuccess(result));
    } catch (e) {
      emit(AuthMovieFailure(e.toString()));
    }
  }
}
