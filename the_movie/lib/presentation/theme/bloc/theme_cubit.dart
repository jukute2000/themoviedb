import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/theme/bloc/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeInitial());

  void setTheme() {
    final currentIsDarkMode = !state.isDarkMode;

    if (!isClosed) emit(ThemeLoaded(isDarkMode: currentIsDarkMode));
  }
}
