import 'package:flutter/material.dart';
import 'package:the_movie/core/comons/widgets/format_date.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/configs/assets/app_strings.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/core/utils/text_manager.dart';
import 'package:the_movie/data/models/medias/tv.dart';
import 'package:the_movie/presentation/theme/screen/app_style_provider.dart';

import '../../../core/configs/assets/app_images.dart';
import '../../../core/utils/sizes_manager.dart';
import '../../../data/models/medias/media.dart';
import '../../../data/models/medias/movie.dart';

class TabViewWidget extends StatelessWidget {
  final Media media;

  const TabViewWidget({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: PaddingSizes.p24, vertical: PaddingSizes.p8),
      child: Card(
        elevation: 4,
        child: SizedBox(
          height: HeightSizes.h150,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(RadiusSizes.r8)),
                child: SizedBox(
                    width: WidthSizes.w100,
                    child: (media.posterPath != null &&
                            media.posterPath!.isNotEmpty)
                        ? Image.network(
                            AppStrings.imageUrl + media.posterPath!,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            AppImages.noImage,
                            fit: BoxFit.cover,
                          )),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(PaddingSizes.p8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(children: [
                          TextSpan(
                            text: media.getTitle(),
                            style: TextManager.textStyleBlod(TextSizes.s16)
                                .copyWith(
                              color: AppStyleProvider.of(context).textColor(),
                            ),
                          ),
                          if (media is TiVi)
                            TextSpan(
                                text: ' (${media.getOriginalTitle()})',
                                style:
                                    TextManager.textStyleMedium(TextSizes.s16)
                                        .copyWith(
                                            color: AppColors.textGrey400)),
                        ]),
                      ),
                      if (media is TiVi || media is Movie)
                        Text(
                          media.getReleaseDate() != null
                              ? FormatDate.format(media.getReleaseDate())
                              : '',
                          style: TextManager.textStyleMedium(TextSizes.s16)
                              .copyWith(color: AppColors.textGrey400),
                        ),
                      GapsManager.h20,
                      Text(
                        media.overview ?? '',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextManager.textStyleRegular(TextSizes.s14)
                            .copyWith(
                          color: AppStyleProvider.of(context).textColor(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
