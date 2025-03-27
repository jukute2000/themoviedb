import 'package:the_movie/data/models/medias/media.dart';

abstract class TrendingWeekState {}

class TrendingWeekInitial extends TrendingWeekState {}

class TrendingWeekIsLoading extends TrendingWeekState {}

class MediasTrendingWeekLoaded extends TrendingWeekState {
  final List<Media> medias;
  MediasTrendingWeekLoaded({required this.medias});
}

class TrendingWeekError extends TrendingWeekState {
  final String message;
  TrendingWeekError(this.message);
}
