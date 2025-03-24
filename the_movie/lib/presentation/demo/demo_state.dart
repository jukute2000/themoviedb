import '../../data/models/medias/media.dart';

abstract class DemoStateCubit {}

class Initial extends DemoStateCubit {}

class IsLoading extends DemoStateCubit {}

class Medias extends DemoStateCubit {
  final List<Media> medias;
  Medias({required this.medias});
}

class Error extends DemoStateCubit {
  final String message;
  Error(this.message);
}
