abstract class BannerState {}

class BannerInitial extends BannerState {}

class BannerIsLoading extends BannerState {}

class BannerLoaded extends BannerState {
  final String? images;
  BannerLoaded({required this.images});
}

class BannerError extends BannerState {}
