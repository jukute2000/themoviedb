import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/configs/assets/app_colors.dart';
import '../../core/configs/assets/app_images.dart';
import '../../core/configs/navigation/app_navigation.dart';
import '../profile/screen/profile_screen.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({
    super.key,
    required ScrollController scrollController,
    required this.body,
    required this.isHome,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final Widget body;
  final bool isHome;
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollController,
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          iconTheme: const IconThemeData(color: AppColors.iconAppbar),
          backgroundColor: AppColors.backgroundAppbar,
          title: SvgPicture.network(
            AppImages.logoAppBar,
            height: 18.h,
            colorFilter: const ColorFilter.mode(
              AppColors.iconAppbar,
              BlendMode.srcIn,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () =>
                  AppNavigator.push(context, const ProfileScreen()),
            ),
            if (!isHome)
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.blue,
                ),
              )
          ],
        )
      ],
      body: body,
    );
  }
}
