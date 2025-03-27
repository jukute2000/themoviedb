import '../../../../data/models/medias/media.dart';

abstract class TrendingState {}

class TrendingInitial extends TrendingState {}

class TrendingIsLoading extends TrendingState {}

class MediasTrendingLoaded extends TrendingState {
  final List<Media> medias;
  MediasTrendingLoaded({required this.medias});
}

class TrendingError extends TrendingState {
  final String message;
  TrendingError(this.message);
}
