import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/configs/assets/app_images.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/presentation/profile/screen/profile_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
          onPressed: () {
            AppNavigator.push(context, const ProfileScreen());
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
