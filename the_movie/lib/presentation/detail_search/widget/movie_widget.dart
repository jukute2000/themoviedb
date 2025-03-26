import 'package:flutter/material.dart';
import 'package:the_movie/core/utils/format_date.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';

import '../../../core/configs/assets/app_images.dart';
import '../../../core/utils/sizes_manager.dart';

class MovieWidget extends StatelessWidget {
  final String title;
  final DateTime releaseDate;
  final String overview;
  final String posterPath;

  const MovieWidget({
    super.key,
    required this.title,
    required this.releaseDate,
    required this.overview,
    required this.posterPath
  });

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
                  child: Image.asset(
                    AppImages.splashBackground,
                    fit: BoxFit.cover,
                  ),
                ),
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
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        FormatDate.format(releaseDate),
                        style: TextStyle(color: Colors.grey.shade400),
                      ),
                      GapsManager.h20,
                      Text(
                        overview,
                        maxLines: 2,
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