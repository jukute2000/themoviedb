import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/configs/assets/app_strings.dart';

import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/navigation/app_navigation.dart';
import '../../../core/utils/sizes_manager.dart';
import '../../../core/utils/text_manager.dart';
import '../../../data/models/people/know_for.dart';
import '../../movie/screen/movie_detail_screen.dart';
import '../../theme/screen/app_style_provider.dart';

class PeopleWidget extends StatefulWidget {
  final String? knownForDepartment;
  final String? name;
  final List<KnowFor>? knownFor;
  final String? profilePath;

  const PeopleWidget(
      {super.key,
      required this.knownForDepartment,
      required this.name,
      required this.knownFor,
      required this.profilePath});

  @override
  State<PeopleWidget> createState() => _PeopleWidgetState();
}

class _PeopleWidgetState extends State<PeopleWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: PaddingSizes.p24, vertical: PaddingSizes.p8),
      child: Card(
        elevation: 4,
        child: SizedBox(
          height: HeightSizes.h100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(RadiusSizes.r8)),
                child: SizedBox(
                    width: WidthSizes.w100,
                    child: (widget.profilePath ?? "").isNotEmpty
                        ? Image.network(
                            AppStrings.imageUrl + widget.profilePath!,
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
                        widget.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextManager.textStyleBlod(TextSizes.s16).copyWith(
                          color: AppStyleProvider.of(context).textColor(),
                        ),
                      ),
                      RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: widget.knownForDepartment,
                                style:
                                    TextManager.textStyleMedium(TextSizes.s16)
                                        .copyWith(
                                  color:
                                      AppStyleProvider.of(context).textColor(),
                                ),
                              ),
                              if ((widget.knownFor ?? []).isNotEmpty)
                                TextSpan(
                                    text: ' - ',
                                    style: TextManager.textStyleMedium(
                                            TextSizes.s16)
                                        .copyWith(
                                      color: AppStyleProvider.of(context)
                                          .textColor(),
                                    )),
                              ...((widget.knownFor ?? []).asMap().entries.map((entry) {
                                final index = entry.key;
                                final item = entry.value;

                                return TextSpan(
                                  text: index == (widget.knownFor!.length - 1)
                                      ? item.name
                                      : '${item.name}, ',
                                  style: TextManager.textStyleRegular(
                                          TextSizes.s14)
                                      .copyWith(
                                    color: AppColors.textGrey400,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Chuyển sang màn hình detail
                                      if (item.id != null) {
                                        AppNavigator.push(
                                          context,
                                          MovieDetailScreen(
                                            id: item.id!,
                                            isMovie: item.mediaType == "movie",
                                          ),
                                        );
                                      }
                                    },
                                );
                              }))
                            ],
                          ))
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
