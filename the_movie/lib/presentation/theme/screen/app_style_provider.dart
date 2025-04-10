import 'package:flutter/material.dart';
import '../../../core/configs/assets/app_theme.dart';

class AppStyleProvider extends InheritedWidget {
  final AppStyle style;

  const AppStyleProvider({
    super.key,
    required this.style,
    required super.child,
  });

  static AppStyle of(BuildContext context) {
    final AppStyleProvider? result =
        context.dependOnInheritedWidgetOfExactType<AppStyleProvider>();
    assert(result != null, 'No AppStyleProvider found in context');
    return result!.style;
  }

  @override
  bool updateShouldNotify(covariant AppStyleProvider oldWidget) {
    return oldWidget.style != style;
  }
}
