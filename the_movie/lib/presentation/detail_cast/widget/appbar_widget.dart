import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/configs/assets/app_colors.dart';
import '../../../core/configs/assets/app_images.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({
    super.key,
    required ScrollController scrollController,
    required this.body,
    required this.onProfilePressed,
  }) : _scrollController = scrollController;
  final VoidCallback onProfilePressed;
  final ScrollController _scrollController;
  final Widget body;
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollController,
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          iconTheme: const IconThemeData(color: AppColors.iconAppbar),
          backgroundColor: AppColors.backgroundBlue900,
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
              onPressed: onProfilePressed,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: AppColors.iconSerach,
              ),
            )
          ],
        )
      ],
      body: body,
    );
  }
}
