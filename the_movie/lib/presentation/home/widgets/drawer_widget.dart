import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:the_movie/core/utils/divider_manager.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/core/utils/text_manager.dart';
import 'package:the_movie/presentation/profile/bloc/profile_detail/profile_detail_cubit.dart';
import 'package:the_movie/presentation/theme/bloc/theme_cubit.dart';
import 'package:the_movie/presentation/theme/screen/app_style_provider.dart';

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
            decoration: BoxDecoration(
              color: AppStyleProvider.of(context).backgroundColor(),
            ),
            child: Padding(
              padding: EdgeInsets.all(PaddingSizes.p8),
              child: Text('Menu',
                  style: TextManager.textStyleBlod(36.sp).copyWith(
                      color: AppStyleProvider.of(context).iconColor())),
            ),
          ),
          ListTile(
              leading: const Icon(Icons.change_circle_outlined),
              title: Text(
                AppStrings.changeTheme.tr(),
                style: TextManager.textStyleMedium(16.sp),
              ),
              onTap: () => context.read<ThemeCubit>().setTheme()),
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

  ListTile _createDrawerItem(IconData icon, String text, {Function? onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        text,
        style: TextManager.textStyleMedium(16.sp),
      ),
      onTap: () {
        onTap;
      },
    );
  }
}
