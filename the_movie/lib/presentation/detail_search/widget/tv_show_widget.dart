import 'package:flutter/material.dart';
import 'package:the_movie/core/comons/widgets/format_date.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';

import '../../../core/configs/assets/app_images.dart';
import '../../../core/constants/strings_manager.dart';
import '../../../core/utils/sizes_manager.dart';

class TvShowWidget extends StatelessWidget {
  final String? title;
  final DateTime? releaseDate;
  final String? overview;
  final String? originalName;
  final String? posterPath;

  const TvShowWidget(
      {super.key,
      required this.title,
      required this.releaseDate,
      required this.overview,
      required this.originalName,
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
                    child: (posterPath != null && posterPath!.isNotEmpty)
                        ? Image.network(
                            StringsManager.imageUrl + posterPath!,
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
                              text: title,
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: ' (',
                              style: TextStyle(color: Colors.grey.shade400),
                            ),
                            TextSpan(
                              text: originalName,
                              style: TextStyle(color: Colors.grey.shade400),
                            ),
                            TextSpan(
                              text: ')',
                              style: TextStyle(color: Colors.grey.shade400),
                            ),
                          ])),
                      Text(
                        FormatDate.format(releaseDate),
                        style: TextStyle(color: Colors.grey.shade400),
                      ),
                      GapsManager.h20,
                      Text(
                        overview ?? '',
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
