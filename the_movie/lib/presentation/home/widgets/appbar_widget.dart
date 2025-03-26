import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/configs/assets/app_images.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onProfilePressed;

  const CustomAppBar({super.key, required this.onProfilePressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: AppColors.iconAppbar),
      backgroundColor: AppColors.backgroundAppbar,
      title: SvgPicture.network(
        AppImages.logoAppBar,
        height: 18,
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
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
