import 'package:flutter/material.dart';

import '../../../core/configs/assets/app_images.dart';
import '../../../core/utils/sizes_manager.dart';

class PeopleWidget extends StatelessWidget {
  final String knownForDepartment;
  final String name;
  final List<String> knownFor;
  final String profilePath;

  const PeopleWidget({
    super.key,
    required this.knownForDepartment,
    required this.name,
    required this.knownFor,
    required this.profilePath
  });

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
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    RichText(
                        text: TextSpan(
                      children: [
                        TextSpan(
                          text: knownForDepartment,
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                            text: ' - ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: knownFor.join(', '),
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
