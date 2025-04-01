import 'package:the_movie/core/configs/assets/app_images.dart';
import 'package:the_movie/core/constans/url_manager.dart';
import 'package:the_movie/data/models/credits/external.dart';

class SocialMedia {
  final String? id;
  final String? icon;
  final String? baseUrl;
  final String? pageName;
  SocialMedia(
      {required this.id,
      required this.icon,
      required this.baseUrl,
      this.pageName});

  static List<SocialMedia> socialMediaSources(External? ex) => [
        SocialMedia(
            id: ex?.facebookId,
            icon: AppImages.facebookIcon,
            baseUrl: UrlManager.facebookBasePart,
            pageName: UrlManager.facebookPackageName),
        SocialMedia(
            id: ex?.instagramId,
            icon: AppImages.instagramIcon,
            baseUrl: UrlManager.instagramBasePart,
            pageName: UrlManager.instagramPackageName),
        SocialMedia(
            id: ex?.tiktokId,
            icon: AppImages.tiktokIcon,
            baseUrl: UrlManager.tiktokBasePart,
            pageName: UrlManager.tiktokPackageName),
        SocialMedia(
            id: ex?.twitterId,
            icon: AppImages.twitterIcon,
            baseUrl: UrlManager.twitterBasePart,
            pageName: UrlManager.twitterPackageName),
        SocialMedia(
            id: ex?.youtubeId,
            icon: AppImages.youtubeIcon,
            baseUrl: UrlManager.youtubeBasePart,
            pageName: UrlManager.youtubePackageName),
      ];
}
