import 'package:flutter/material.dart';
import 'package:the_movie/core/configs/assets/app_strings.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/core/utils/text_manager.dart';

import '../../../core/configs/assets/app_images.dart';

import '../../../core/utils/sizes_manager.dart';

class CollectionWidget extends StatelessWidget {
  final String title;
  final String overview;
  final String posterPath;

  const CollectionWidget(
      {super.key,
      required this.title,
      required this.overview,
      required this.posterPath});

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
                    child: (posterPath.isNotEmpty)
                        ? Image.network(
                            AppStrings.imageUrl + posterPath,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextManager.textStyleMedium(TextSizes.s16),
                      ),
                      GapsManager.h20,
                      Text(
                        overview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextManager.textStyleRegular(TextSizes.s14),
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
