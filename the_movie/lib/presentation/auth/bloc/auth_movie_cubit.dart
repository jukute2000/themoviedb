import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/repositories/auth_repository.dart';
import 'package:the_movie/presentation/auth/bloc/auth_movie_state.dart';

class AuthMovieCubit extends Cubit<AuthMovieState> {
  AuthMovieCubit() : super(AuthMovieInitial());

  Future<void> login({
    required String name,
    required String password,
  }) async {
    if (!isClosed) emit(AuthMovieLoading());
    try {
      final bool result =
          await AuthRepositoryImpl.instance.loginUser(name, password);
      if (!isClosed) emit(AuthMovieSuccess(result));
    } catch (e) {
      if (!isClosed) emit(AuthMovieFailure(e.toString()));
    }
  }
}
