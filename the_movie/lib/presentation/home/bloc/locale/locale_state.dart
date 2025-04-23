import 'package:flutter/material.dart';

abstract class LocaleState {
  final Locale locale;
  LocaleState({required this.locale});
}

class LocaleLoaded extends LocaleState {
  LocaleLoaded({required super.locale});
}
