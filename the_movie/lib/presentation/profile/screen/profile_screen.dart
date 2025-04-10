import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/presentation/home/widgets/title_widget.dart';
import 'package:the_movie/presentation/profile/widgets/movies_favourites_widget.dart';
import 'package:the_movie/presentation/profile/widgets/profile_detail.dart';
import 'package:the_movie/presentation/profile/widgets/tivi_favourites_widget.dart';
import 'package:the_movie/presentation/widgets/appbar_widget.dart';

import '../../../core/configs/assets/app_strings.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AppbarWidget(
      scrollController: _scrollController,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProfileDetail(),
            TitleWidget(
              title: AppStrings.moviesFavourites.tr(),
              fontSize: 28.sp,
            ),
            const MoviesFavouritesWidget(),
            TitleWidget(
              title: AppStrings.tiviFavourites.tr(),
              fontSize: 28.sp,
            ),
            const TiviFavouritesWidget(),
          ],
        ),
      ),
      isHome: false,
      isSearch: false,
    ));
  }
}
