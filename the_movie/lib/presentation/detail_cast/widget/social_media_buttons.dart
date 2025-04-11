import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/data/models/credits/external.dart';
import 'package:the_movie/data/models/credits/social_media.dart';
import '../bloc/detail_cast/detail_cast_cubit.dart';

Widget buildSocialMediaButtons(BuildContext context, External? external) {
  final socialMedia = SocialMedia.socialMediaSources(external);
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: socialMedia
        .where((item) => item.id != null)
        .map(
          (item) => TextButton(
            onPressed: () =>
                context.read<DetailCastCubit>().openSocialMedia(item),
            child: Image.asset(
              item.icon!,
              color: AppColors.iconAppbar,
            ),
          ),
        )
        .toList(),
  );
}
