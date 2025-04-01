import 'package:flutter/material.dart';
import 'package:the_movie/core/comons/widgets/format_date.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/data/models/medias/tv.dart';

import '../../../core/configs/assets/app_images.dart';
import '../../../core/constants/strings_manager.dart';
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
                            StringsManager.imageUrl + media.posterPath!,
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
                              style: const TextStyle(color: Colors.black),
                            ),
                            if (media is TiVi)
                              TextSpan(
                                text: ' (${media.getOriginalTitle()})',
                                style: TextStyle(color: Colors.grey.shade400),
                              ),
                          ])),
                      if (media is TiVi || media is Movie)
                        Text(
                          media.getReleaseDate() != null
                              ? FormatDate.format(media.getReleaseDate())
                              : '',
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                      GapsManager.h20,
                      Text(
                        media.overview ?? '',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
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
