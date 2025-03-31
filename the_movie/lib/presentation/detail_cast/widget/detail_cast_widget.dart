import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/assets/app_images.dart';
import 'package:the_movie/core/utils/divider_manager.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/data/models/credits/external.dart';
import 'package:the_movie/data/models/people/people_detail.dart';
import 'package:the_movie/presentation/detail_cast/widget/biography_widget.dart';
import 'package:the_movie/presentation/detail_cast/widget/social_media_buttons.dart';

class DetailCastWidget extends StatelessWidget {
  final PeopleDetail peopleDetail;
  final External external;
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
                borderRadius: BorderRadius.circular(10),
                child: peopleDetail.profilePath != null
                    ? Image.network(
                        AppImages.getImageUrlCast(peopleDetail.profilePath!),
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
                peopleDetail.name ?? '',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
              GapsManager.h10,
              Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(PaddingSizes.p16),
                  child: Column(
                    children: [
                      _buildInfoRow('Known For',
                          peopleDetail.knownForDepartment.toString()),
                      DividerManager.horizontalDivider,
                      _buildInfoRow(
                          'Known Credits', peopleDetail.id.toString()),
                      DividerManager.horizontalDivider,
                      _buildInfoRow('Gender',
                          peopleDetail.gender == 1 ? "Male" : "Female"),
                      DividerManager.horizontalDivider,
                      _buildInfoRow(
                        'Birthday',
                        DateFormat('MMMM dd, yyyy')
                            .format(peopleDetail.birthday ?? DateTime.now()),
                      ),
                      DividerManager.horizontalDivider,
                      _buildInfoRow(
                          'Place of Birth', peopleDetail.placeOfBirth ?? ''),
                    ],
                  ),
                ),
              ),
              GapsManager.h20,
              BiographyWidget(
                fullText: peopleDetail.biography ??
                    'No information available about this castor.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      TextSpan(text: value),
                    ],
                    style: const TextStyle(
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
