import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/home/bloc/locale/locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleLoaded(locale: const Locale('vi')));

  void onchange() {
    state.locale.languageCode == 'en'
        ? emit(LocaleLoaded(locale: const Locale('vi')))
        : emit(LocaleLoaded(locale: const Locale('en')));
  }
}
