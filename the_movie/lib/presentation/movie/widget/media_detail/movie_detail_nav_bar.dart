import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import '../../../../core/utils/text_manager.dart';

class MovieDetailNavBar extends StatelessWidget {
  const MovieDetailNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(PaddingSizes.p4),
      child: Row(
        children: [
          _buildNavButton(context, 'Overview', const OverviewDropdownMenu()),
          _buildNavButton(context, 'Media', const MediaDropdownMenu()),
          _buildNavButton(context, 'Fandom', null),
          _buildNavButton(context, 'Share', null),
        ],
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, String title, Widget? menu) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 8.w),
      child: InkWell(
        onTap: () => menu != null
            ? showMenu(
                context: context,
                position: const RelativeRect.fromLTRB(0, 142, 0, 0),
                items: [PopupMenuItem(child: menu)],
              )
            : null,
        child: Row(
          children: [
            Text(title, style: TextManager.textStyleMedium(TextSizes.s16)),
            Icon(Icons.arrow_drop_down, size: 20.h),
          ],
        ),
      ),
    );
  }
}

class MediaDropdownMenu extends StatelessWidget {
  const MediaDropdownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _mediaItem('Backdrops', '104'),
          _mediaItem('Logos', '113'),
          _mediaItem('Posters', '138'),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Videos',
                    style: TextManager.textStyleMedium(TextSizes.s16)),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// tach code ta
  Widget _mediaItem(String title, String count) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextManager.textStyleMedium(TextSizes.s16)),
          Text(count, style: TextManager.textStyleMedium(TextSizes.s16)),
        ],
      ),
    );
  }
}

class OverviewDropdownMenu extends StatelessWidget {
  const OverviewDropdownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      width: double.infinity,
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(4),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _menuItem('Main'),
          _menuItem('Alternative Titles'),
          _menuItem('Cast & Crew'),
          _menuItem('Episode Groups'),
          _menuItem('Seasons'),
          _menuItem('Translations'),
          _menuItem('Changes'),
        ],
      ),
    );
  }

  Widget _menuItem(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(title, style: TextManager.textStyleMedium(TextSizes.s14)),
    );
  }
}
