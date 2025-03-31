import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/core/configs/assets/app_images.dart';

import '../../../core/constans/url_manager.dart';
import '../bloc/detail_cast/detail_cast_cubit.dart';

Widget buildSocialMediaButtons(BuildContext context, external) {
  final socialMedia = [
    {
      'id': external.facebookId,
      'icon': AppImages.facebookIcon,
      'base': UrlManager.facebookBasePart
    },
    {
      'id': external.instagramId,
      'icon': AppImages.instagramIcon,
      'base': UrlManager.instagramBasePart
    },
    {
      'id': external.tiktokId,
      'icon': AppImages.tiktokIcon,
      'base': UrlManager.tiktokBasePart
    },
    {
      'id': external.twitterId,
      'icon': AppImages.twitterIcon,
      'base': UrlManager.twitterBasePart
    },
    {
      'id': external.youtubeId,
      'icon': AppImages.youtubeIcon,
      'base': UrlManager.youtubeBasePart
    },
  ];

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: socialMedia
        .where((item) => item['id'] != null)
        .map(
          (item) => TextButton(
            onPressed: () => context.read<DetailCastCubit>().launchURL(
                  item['base'],
                  item['id'],
                ),
            child: Image.asset(item['icon']),
          ),
        )
        .toList(),
  );
}
