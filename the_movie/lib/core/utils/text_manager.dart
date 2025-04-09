import 'package:flutter/material.dart';

class TextManager {
  //SourceSans3
  //abtract để sử dụng cho cho cả theme dark và light
  static TextStyle textStyleLight(double size) => TextStyle(
        fontSize: size,
        fontFamily: 'Source',
        fontWeight: FontWeight.w300,
      );
  static TextStyle textStyleRegular(double size) => TextStyle(
        fontSize: size,
        fontFamily: 'Source',
        fontWeight: FontWeight.w400,
      );
  static TextStyle textStyleMedium(double size) => TextStyle(
        fontSize: size,
        fontFamily: 'Source',
        fontWeight: FontWeight.w500,
      );
  static TextStyle textStyleBlod(double size) => TextStyle(
        fontSize: size,
        fontFamily: 'Source',
        fontWeight: FontWeight.w700,
      );
  static TextStyle textStyleBlack(double size) => TextStyle(
        fontSize: size,
        fontFamily: 'Source',
        fontWeight: FontWeight.w900,
      );
}
