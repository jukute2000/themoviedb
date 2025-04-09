import 'package:flutter/material.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';

abstract class AppStyle {
  late ThemeData themeData;
}

class LightTheme extends AppStyle {
  @override
  ThemeData get themeData => ThemeData.light(
        useMaterial3: true,
      ).copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.backgroundAppbar,
          iconTheme: IconThemeData(color: AppColors.iconAppbar),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: AppColors.textGrey,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
          bodySmall: TextStyle(color: Colors.black),
          titleLarge: TextStyle(color: Colors.black),
          titleMedium: TextStyle(color: Colors.black),
          titleSmall: TextStyle(color: Colors.black),
        ),
      );
}

class DarkTheme extends AppStyle {
  @override
  ThemeData get themeData => ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: AppColors.iconAppbar),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
          titleLarge:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
        ),
      );
}
