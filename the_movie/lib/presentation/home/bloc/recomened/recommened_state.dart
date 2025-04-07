import 'package:the_movie/data/models/media_detail/detail_media/detail_meida.dart';

abstract class RecommenedState {}

class RecommenedInitial extends RecommenedState {}

class RecommenedIsLoading extends RecommenedState {}

class RecommenedLoaded extends RecommenedState {
  final List<DetailMedia> listMediaDetail;

  RecommenedLoaded({required this.listMediaDetail});
}

class RecommenedError extends RecommenedState {
  final String message;
  RecommenedError(this.message);
}
