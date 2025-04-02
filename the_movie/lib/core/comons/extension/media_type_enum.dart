enum MediaTypeEnum {
  tv,
  movie,
}

extension MediaTypeExtension on MediaTypeEnum {
  String get name {
    switch (this) {
      case MediaTypeEnum.movie:
        return "Movie";
      case MediaTypeEnum.tv:
        return "Tv";
    }
  }

  static MediaTypeEnum? fromString(String value) {
    switch (value) {
      case "Movie":
        return MediaTypeEnum.movie;
      case "Tv":
        return MediaTypeEnum.tv;
      default:
        return null;
    }
  }
}
