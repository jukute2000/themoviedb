import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/utils/divider_manager.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/data/repositories/auth_repository.dart';

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
          _createDrawerItem(Icons.favorite, "Favorites"),
          _createDrawerItem(Icons.group, "Friends"),
          _createDrawerItem(Icons.share, "Share"),
          _createDrawerItem(Icons.notifications, "Request"),
          DividerManager.horizontalDivider,
          _createDrawerItem(Icons.settings, "Settings"),
          _createDrawerItem(Icons.policy, "Policies"),
          DividerManager.horizontalDivider,
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Exit"),
            onTap: () {
              // Xử lý sự kiện khi nhấn vào mục
              AuthRepositoryImpl.instance.logOut();
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
