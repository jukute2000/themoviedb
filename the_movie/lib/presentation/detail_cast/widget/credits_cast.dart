import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/comons/extension/media_type_enum.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
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
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const SizedBox(),
              Row(
                children: [
                  if (detailCast.isClear)
                    TextButton(
                      onPressed: () => detailCast.resetFilter(),
                      child: const Text(
                        "Clear",
                        style: TextStyle(color: AppColors.iconAppbar),
                      ),
                    ),
                  GapsManager.h20,
                  PopupMenuButton<MediaTypeEnum>(
                    onSelected: (value) {
                      detailCast.filterCast(value);
                    },
                    child: const Row(
                      children: [Text("All"), Icon(Icons.arrow_drop_down)],
                    ),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: MediaTypeEnum.movie, // Đã sửa đúng kiểu dữ liệu
                        child: Text("Movie"),
                      ),
                      const PopupMenuItem(
                        value: MediaTypeEnum.tv, // Đã sửa đúng kiểu dữ liệu
                        child: Text("TV"),
                      ),
                    ],
                  ),
                  GapsManager.w20,
                  PopupMenuButton(
                    onSelected: (value) {
                      detailCast.filterCrewByDepartment(value);
                    },
                    child: const Row(
                      children: [
                        Text("Deparment"),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                    itemBuilder: (context) => detailCast.originalCrews.keys
                        .map(
                          (e) => PopupMenuItem(
                            value: e,
                            child: Text(
                                "$e (${detailCast.originalCrews[e]?.length ?? "_"})"),
                          ),
                        )
                        .toList(),
                  )
                ],
              ),
            ],
          ),
          CreditsWidget(medias: widget.medias),
          CrewWidget(context, widget.crews),
        ],
      ),
    );
  }
}
