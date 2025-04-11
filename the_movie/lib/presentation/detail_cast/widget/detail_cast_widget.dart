import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/assets/app_images.dart';
import 'package:the_movie/core/utils/divider_manager.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/core/utils/text_manager.dart';
import 'package:the_movie/data/models/credits/external.dart';
import 'package:the_movie/data/models/people/people_detail.dart';
import 'package:the_movie/presentation/detail_cast/widget/biography_widget.dart';
import 'package:the_movie/presentation/detail_cast/widget/social_media_buttons.dart';
import 'package:the_movie/presentation/theme/screen/app_style_provider.dart';

import '../../../core/configs/assets/app_strings.dart';

class DetailCastWidget extends StatelessWidget {
  final PeopleDetail? peopleDetail;
  final External? external;
  const DetailCastWidget(
      {super.key, required this.peopleDetail, required this.external});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(PaddingSizes.p16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(RadiusSizes.r8),
                child: peopleDetail?.profilePath != null
                    ? Image.network(
                        AppImages.getImageUrlCast(peopleDetail!.profilePath!),
                        width: 172.w,
                        height: 172.h,
                        fit: BoxFit.cover,
                      )
                    : Image(
                        image: const AssetImage(AppImages.noImage),
                        width: 172.w,
                        height: 172.h,
                        fit: BoxFit.cover,
                      ),
              ),
              GapsManager.h10,
              buildSocialMediaButtons(context, external),
              GapsManager.h10,
              Text(
                peopleDetail?.name ?? AppStrings.noInfomation.tr(),
                style: TextManager.textStyleBlod(TextSizes.s24)
                    .copyWith(color: AppStyleProvider.of(context).textColor()),
              ),
              GapsManager.h10,
              Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(PaddingSizes.p16),
                  child: Column(
                    children: [
                      _buildInfoRow(
                          context,
                          AppStrings.knownFor.tr(),
                          peopleDetail?.knownForDepartment.toString() ??
                              AppStrings.noInfomation.tr()),
                      DividerManager.horizontalDivider,
                      _buildInfoRow(
                          context,
                          AppStrings.knownCredits.tr(),
                          peopleDetail?.id.toString() ??
                              AppStrings.noInfomation.tr()),
                      DividerManager.horizontalDivider,
                      _buildInfoRow(
                          context,
                          AppStrings.gender.tr(),
                          peopleDetail?.gender == -1 ||
                                  peopleDetail?.gender == null
                              ? AppStrings.noInfomation.tr()
                              : peopleDetail!.gender == 1
                                  ? AppStrings.female.tr()
                                  : AppStrings.male.tr()),
                      DividerManager.horizontalDivider,
                      _buildInfoRow(
                        context,
                        AppStrings.birthday.tr(),
                        peopleDetail?.birthday == null
                            ? AppStrings.noInfomation.tr()
                            : DateFormat('MMMM dd, yyyy')
                                .format(peopleDetail!.birthday!),
                      ),
                      DividerManager.horizontalDivider,
                      _buildInfoRow(
                          context,
                          AppStrings.placeOfBirth.tr(),
                          peopleDetail?.placeOfBirth ??
                              AppStrings.noInfomation.tr()),
                    ],
                  ),
                ),
              ),
              GapsManager.h20,
              BiographyWidget(
                fullText:
                    peopleDetail?.biography ?? AppStrings.noInfomation.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.all(PaddingSizes.p16),
      child: value.length < 20
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextManager.textStyleBlod(TextSizes.s16).copyWith(
                      color: AppStyleProvider.of(context).textColor()),
                ),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextManager.textStyleRegular(TextSizes.s16).copyWith(
                      color: AppStyleProvider.of(context).textColor()),
                ),
              ],
            )
          : Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "$label\n",
                        style: TextManager.textStyleBlod(TextSizes.s16)
                            .copyWith(
                                color:
                                    AppStyleProvider.of(context).textColor()),
                      ),
                      TextSpan(
                        text: value,
                        style: TextManager.textStyleRegular(TextSizes.s16)
                            .copyWith(
                                color:
                                    AppStyleProvider.of(context).textColor()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
