import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:the_movie/core/utils/divider_manager.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/data/models/medias/media.dart';
import '../../../core/configs/assets/app_strings.dart';
import '../../../core/configs/navigation/app_navigation.dart';
import '../../../core/utils/sizes_manager.dart';
import '../../../core/utils/text_manager.dart';
import '../../movie/screen/movie_detail_screen.dart';
import '../../theme/screen/app_style_provider.dart';

class CreditsWidget extends StatefulWidget {
  const CreditsWidget({super.key, required this.medias});
  final List<Media>? medias;
  @override
  State<CreditsWidget> createState() => _CreditsWidgetState();
}

class _CreditsWidgetState extends State<CreditsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GapsManager.h10,
        widget.medias == null
            ? const SizedBox()
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.medias!.length,
                itemBuilder: (context, index) {
                  Media media = widget.medias![index];
                  int currentYear = int.tryParse(media.getYear()) ?? -1;
                  int previousYear = index > 0
                      ? int.tryParse(widget.medias![index - 1].getYear()) ?? -1
                      : currentYear;
                  return Column(
                    children: [
                      if (index > 0 && currentYear != previousYear)
                        DividerManager.horizontalDivider,
                      ListTile(
                        leading: Text(
                          media.getYear() != "" ? media.getYear() : "_",
                          style: TextManager.textStyleMedium(TextSizes.s16)
                              .copyWith(
                                  color:
                                      AppStyleProvider.of(context).textColor()),
                        ),
                        title: GestureDetector(
                          onTap: () {
                            if (media.id != -1) {
                              AppNavigator.push(
                                context,
                                MovieDetailScreen(
                                  id: media.id!,
                                  isMovie: media.isMovie(),
                                ),
                              );
                            }
                          },
                          child: Text(
                            media.getTitle(),
                            style: TextManager.textStyleBlod(TextSizes.s16)
                                .copyWith(
                                    color: AppStyleProvider.of(context)
                                        .textColor()),
                          ),
                        ),
                        subtitle: Text(
                          media.charater ?? AppStrings.noInfomation.tr(),
                          style: TextManager.textStyleRegular(TextSizes.s16)
                              .copyWith(
                                  color:
                                      AppStyleProvider.of(context).textColor()),
                        ),
                      ),
                    ],
                  );
                },
              )
      ],
    );
  }
}
