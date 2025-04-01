import 'package:the_movie/data/models/keyword/keyword.dart';

abstract class KeyWordState {}

class KeyWordInitial extends KeyWordState {}

class KeyWordIsLoading extends KeyWordState {}

class KeyWordLoaded extends KeyWordState {
  final List<Keyword> listKeyWord;
  KeyWordLoaded({required this.listKeyWord});
}

class KeyWordError extends KeyWordState {
  final String message;
  KeyWordError(this.message);
}
