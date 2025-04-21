import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  // Home
  static const Color iconAppbar = Color.fromARGB(255, 55, 194, 194);
  static const Color backgroundAppbar = Color.fromARGB(255, 13, 81, 136);
  static const Color overlayBanner = Color.fromARGB(128, 43, 109, 127);
  static const Color shawdowListView = Color.fromARGB(25, 0, 0, 0);
  static const Color textWhite = Colors.white;
  static const Color containerWhite = Colors.white;
  static const Color iconSerach = Colors.blue;
  static const Color goodVoteItem = Colors.green;
  static const Color badVoteItem = Color.fromARGB(255, 255, 160, 0);
  static const Color textDay = Colors.grey;
  static const Color boderContainer = Colors.blueGrey;
  static const Color todaySelected = Colors.blueGrey;
  static const Color todayUnSelected = Colors.transparent;
  static const Color textTodaySelected = Colors.cyanAccent;
  static const Color textTodayUnSelected = Colors.black;

  // DetailMovie

  static const Color containerCetificate = Color.fromARGB(255, 207, 207, 207);
  static const Color containerIcon = Color.fromARGB(255, 38, 50, 56);
  static const Color iconChoose = Colors.red;
  static const Color iconUnChoose = Colors.white;
  //keyWord
  static const Color containerKeyWordSelected =
      Color.fromRGBO(187, 222, 251, 1);
  static const Color containerKeyWordUnSelected =
      Color.fromRGBO(238, 238, 238, 1);
  static Color backgroundWhite = Colors.white.withValues(alpha: 0.9);
  static const Color borderSelected = Colors.blue;
  static const Color borderUnSelected = Colors.transparent;
  static const Color textKeywordSelected = Color.fromRGBO(21, 101, 192, 1);
  static const Color textKeywordUnSelected = Colors.black87;

  static const Color containerNavBar = Color.fromARGB(240, 0, 20, 0);
  static const Color backdropImage = Color.fromRGBO(66, 66, 66, 1);
  static const Color posterImage = Color.fromRGBO(97, 97, 97, 1);
  static const Color iconNotSuport = Colors.white;
  static const Color divider = Colors.black;

  static const Color textBlack = Colors.black;
  static const Color iconBlack = Colors.black;
  static const Color textBlack87 = Colors.black87;
  static const Color iconBlack87 = Colors.black87;
  static const Color textGrey = Colors.grey;

  static const Color textTagLine = Color.fromARGB(255, 212, 208, 208);
  static const Color textWhite70 = Colors.white70;

  static const Color ratingRed = Colors.red;
  static const Color ratingYellow = Colors.yellow;
  static const Color ratingGreen = Colors.green;
  static const Color ratingyellowhigh = Color.fromARGB(255, 185, 223, 15);

  static const Color boxShadowBlack = Colors.black;

  static const Color textGreyShade600 = Color.fromRGBO(117, 117, 117, 1);
  static const Color textGreyShade100 = Color.fromRGBO(245, 245, 245, 1);
  static const Color textGreyShade800 = Color.fromRGBO(66, 66, 66, 1);
  static const Color textTransparent = Colors.transparent;
  static const Color foregroundRating = Colors.white;
  static const Color verticalDevicde = Colors.white54;

  // Profie
  static const Color containerProfile = Color(0xFF0B2A47);
  static const Color backgroundProfile = Colors.teal;
  // Splash

  static const Color boxBegin = Color(0xff1A1B20);
  static const Color boxEnd = Color(0xff1A1B20);
  // Cast
  static const Color textBlue = Colors.blue;
  static const Color backgroundBlue900 = Color.fromRGBO(13, 71, 161, 1);
  // Search

  static const Color textGrey400 = Color.fromRGBO(189, 189, 189, 1);

  static Color getRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  static Color getTextColor(Color bgColor) {
    final brightness = bgColor.computeLuminance();
    return brightness > 0.5 ? Colors.black : Colors.white;
  }
}
