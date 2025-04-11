abstract class ThemeState {
  final bool isDarkMode;
  const ThemeState({required this.isDarkMode});
}

class ThemeInitial extends ThemeState {
  const ThemeInitial() : super(isDarkMode: false);
}

class ThemeLoaded extends ThemeState {
  const ThemeLoaded({required super.isDarkMode});
}
