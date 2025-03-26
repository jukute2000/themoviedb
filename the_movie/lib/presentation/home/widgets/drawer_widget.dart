import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 13, 81, 136),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          _createDrawerItem(Icons.favorite, "Favorites"),
          _createDrawerItem(Icons.group, "Friends"),
          _createDrawerItem(Icons.share, "Share"),
          _createDrawerItem(Icons.notifications, "Request"),
          const Divider(),
          _createDrawerItem(Icons.settings, "Settings"),
          _createDrawerItem(Icons.policy, "Policies"),
          const Divider(),
          _createDrawerItem(Icons.exit_to_app, "Exit"),
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
