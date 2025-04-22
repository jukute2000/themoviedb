abstract class AuthMovieState {}

class AuthMovieInitial extends AuthMovieState {}

class AuthMovieLoading extends AuthMovieState {}

class AuthMovieSuccess extends AuthMovieState {
  final bool result;
  AuthMovieSuccess(this.result);
}

class AuthMovieFailure extends AuthMovieState {
  final String error;

  AuthMovieFailure(this.error);
}
