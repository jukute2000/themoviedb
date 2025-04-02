import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/utils/divider_manager.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/presentation/profile/bloc/profile_detail/profile_detail_cubit.dart';

import '../../../core/configs/assets/app_strings.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.backgroundAppbar,
            ),
            child: Padding(
              padding: EdgeInsets.all(PaddingSizes.p8),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: AppColors.iconAppbar,
                  fontWeight: FontWeight.bold,
                  fontSize: 32.sp,
                ),
              ),
            ),
          ),
          _createDrawerItem(Icons.favorite, AppStrings.favorites.tr()),
          _createDrawerItem(Icons.group, AppStrings.friends.tr()),
          _createDrawerItem(Icons.share, AppStrings.request.tr()),
          _createDrawerItem(Icons.notifications, AppStrings.share.tr()),
          DividerManager.horizontalDivider,
          _createDrawerItem(Icons.settings, AppStrings.request.tr()),
          _createDrawerItem(Icons.policy, AppStrings.settings.tr()),
          DividerManager.horizontalDivider,
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: Text(AppStrings.exit.tr()),
            onTap: () {
              // Xử lý sự kiện khi nhấn vào mục
              // AuthRepositoryImpl.instance.logOut();
              context.read<ProfileDetailCubit>().logOut();
            },
          ),
          // _createDrawerItem(Icons.exit_to_app, "Exit"),
        ],
      ),
    );
  }

  ListTile _createDrawerItem(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: () {
        // Xử lý sự kiện khi nhấn vào mục
        print("Clicked on $text");
      },
    );
  }
}
