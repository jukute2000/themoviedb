import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/core/utils/divider_manager.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/presentation/movie/screen/movie_detail_screen.dart';
import '../../../core/configs/assets/app_strings.dart';
import '../../../data/models/credits/combined_credit.dart/crew.dart';

Widget CrewWidget(BuildContext context, Map<String?, List<Crew>?>? crews) {
  return crews == null
      ? const SizedBox()
      : Column(
          children: crews.entries
              .map(
                (e) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      e.key!,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: e.value!.length,
                      itemBuilder: (context, index) {
                        Crew crew = e.value![index];
                        int currentYear = crew.getDateTime();
                        int previousYear = index > 0
                            ? e.value![index - 1].getDateTime()
                            : currentYear;
                        return Column(
                          children: [
                            if (index > 0 && currentYear != previousYear)
                              DividerManager.horizontalDivider,
                            ListTile(
                              leading: Text(
                                crew.getDateTime() != 0
                                    ? crew.getDateTime().toString()
                                    : "_",
                              ),
                              title: GestureDetector(
                                  onTap: () {
                                    if (crew.id != -1) {
                                      AppNavigator.push(
                                        context,
                                        MovieDetailScreen(
                                          id: crew.id!,
                                          isMovie: crew.isMovie(),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(crew.getTitle() ??
                                      AppStrings.noInfomation.tr())),
                              subtitle: Text(
                                  crew.job ?? AppStrings.noInfomation.tr()),
                            ),
                          ],
                        );
                      },
                    ),
                    GapsManager.h20,
                  ],
                ),
              )
              .toList(),
        );
}
