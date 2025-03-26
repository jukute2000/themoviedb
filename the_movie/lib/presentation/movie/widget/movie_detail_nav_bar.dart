import 'package:flutter/material.dart';

class MovieDetailNavBar extends StatelessWidget {
  const MovieDetailNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8),
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
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
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
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.black, size: 20),
          ],
        ),
      ),
    );
  }
}

class MediaDropdownMenu extends StatelessWidget {
  const MediaDropdownMenu({Key? key}) : super(key: key);

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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Videos',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.black54,
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
          Text(
            count,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class OverviewDropdownMenu extends StatelessWidget {
  const OverviewDropdownMenu({Key? key}) : super(key: key);

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
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black87,
        ),
      ),
    );
  }
}
