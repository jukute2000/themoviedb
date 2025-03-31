class AppImages {
  static String getImageUrl(String postPath) {
    return "https://media.themoviedb.org/t/p/w440_and_h660_face/$postPath";
  }

  static String getImageUrlCast(String profiletPath) {
    return "https://media.themoviedb.org/t/p/w375_and_h375_face/$profiletPath";
  }

  static String getImageBackdrop(String backdropPath) {
    return "https://image.tmdb.org/t/p/w780$backdropPath";
  }

  static String getImagePoster(String posterPath) {
    return "https://image.tmdb.org/t/p/w200$posterPath";
  }

  static const basePath = 'assets/images/';

  static const splashBackground = '${basePath}splash-bg.png';

  static const noImage = '${basePath}no_image.png';
  static const facebookIcon = '${basePath}facebook.png';
  static const instagramIcon = '${basePath}instagram.png';
  static const tiktokIcon = '${basePath}tiktok.png';
  static const twitterIcon = '${basePath}twitter.png';
  static const wikiIcon = '${basePath}wiki.png';
  static const youtubeIcon = '${basePath}youtube.png';

  static const logoAppBar =
      "https://www.themoviedb.org/assets/2/v4/logos/v2/blue_short-8e7b30f73a4020692ccca9c88bafe5dcb6f8a62a4c6bc55cd9ba82bb2cd95f6c.svg";

  static const banerImage =
      "https://th.bing.com/th/id/OIP.SkqMtqcc6_52knAOaV6tAwHaEo?rs=1&pid=ImgDetMain";
}
