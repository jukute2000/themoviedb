import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/core/comons/extension/media_type_enum.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/core/utils/text_manager.dart';
import 'package:the_movie/presentation/detail_cast/bloc/detail_cast/detail_cast_cubit.dart';
import 'package:the_movie/presentation/detail_cast/widget/credits_widget.dart';
import 'package:the_movie/presentation/detail_cast/widget/crew_widget.dart';
import '../../../data/models/credits/combined_credit.dart/crew.dart';
import '../../../data/models/medias/media.dart';

class CreditsCast extends StatefulWidget {
  const CreditsCast({super.key, required this.medias, required this.crews});
  final List<Media>? medias;
  final Map<String?, List<Crew>?>? crews;
  @override
  State<CreditsCast> createState() => _CreditsCastState();
}

class _CreditsCastState extends State<CreditsCast> {
  @override
  Widget build(BuildContext context) {
    final detailCast = context.read<DetailCastCubit>();
    return Padding(
      padding: EdgeInsets.all(PaddingSizes.p32),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.medias != null
                  ? Text(
                      "Acting",
                      style: TextManager.textStyleBlod(TextSizes.s20),
                    )
                  : const SizedBox(),
              Row(
                children: [
                  if (detailCast.isClear)
                    TextButton(
                      onPressed: () => detailCast.resetFilter(),
                      child: Text(
                        "Clear",
                        style: TextManager.textStyleMedium(TextSizes.s16)
                            .copyWith(color: AppColors.textBlue),
                      ),
                    ),
                  GapsManager.h20,
                  PopupMenuButton<MediaTypeEnum>(
                    onSelected: (value) {
                      detailCast.filterCast(value);
                    },
                    child: Row(
                      children: [
                        Text(
                          "All",
                          style: TextManager.textStyleMedium(TextSizes.s16),
                        ),
                        const Icon(Icons.arrow_drop_down)
                      ],
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: MediaTypeEnum.movie, // Đã sửa đúng kiểu dữ liệu
                        child: Text(
                          "Movie",
                          style: TextManager.textStyleMedium(TextSizes.s16),
                        ),
                      ),
                      PopupMenuItem(
                        value: MediaTypeEnum.tv, // Đã sửa đúng kiểu dữ liệu
                        child: Text(
                          "TV",
                          style: TextManager.textStyleMedium(TextSizes.s16),
                        ),
                      ),
                    ],
                  ),
                  GapsManager.w20,
                  PopupMenuButton(
                    onSelected: (value) {
                      detailCast.filterCrewByDepartment(value);
                    },
                    child: Row(
                      children: [
                        Text(
                          "Deparment",
                          style: TextManager.textStyleMedium(TextSizes.s16),
                        ),
                        const Icon(Icons.arrow_drop_down)
                      ],
                    ),
                    itemBuilder: (context) => detailCast.originalCrews.keys
                        .map(
                          (e) => PopupMenuItem(
                            value: e,
                            child: Text(
                              "$e (${detailCast.originalCrews[e]?.length ?? "_"})",
                              style: TextManager.textStyleMedium(TextSizes.s16),
                            ),
                          ),
                        )
                        .toList(),
                  )
                ],
              ),
            ],
          ),
          CreditsWidget(medias: widget.medias),
          CrewWidget(crews: widget.crews),
        ],
      ),
    );
  }
}
