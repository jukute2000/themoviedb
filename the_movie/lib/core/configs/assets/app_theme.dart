import 'package:flutter/material.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';

abstract class AppStyle {
  late ThemeData themeData;
  Color textColor();
  Color backgroundColor();
  Color iconColor() => AppColors.iconAppbar;
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
        bottomAppBarTheme: const BottomAppBarTheme(
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

  @override
  Color textColor() => AppColors.textBlack;

  @override
  Color backgroundColor() => AppColors.backgroundAppbar;
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
  @override
  Color textColor() => AppColors.textWhite;

  @override
  Color backgroundColor() => Colors.black;
}
