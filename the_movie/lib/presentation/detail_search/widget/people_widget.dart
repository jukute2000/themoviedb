import 'package:flutter/material.dart';
import 'package:the_movie/core/configs/assets/app_strings.dart';

import '../../../core/configs/assets/app_images.dart';
import '../../../core/utils/sizes_manager.dart';
import '../../../data/models/people/know_for.dart';

class PeopleWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: PaddingSizes.p24, vertical: PaddingSizes.p8),
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
                  child: (profilePath ?? "").isNotEmpty
                      ? Image.network(
                          AppStrings.imageUrl + profilePath!,
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
                      name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    RichText(
                        text: TextSpan(
                      children: [
                        TextSpan(
                          text: knownForDepartment,
                          style: const TextStyle(color: Colors.black),
                        ),
                        const TextSpan(
                            text: ' - ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: (knownFor ?? []).join(', '),
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
