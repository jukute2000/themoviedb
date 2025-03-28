import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/detail_cast/bloc/biography/biography_state.dart';

class BiographyCubit extends Cubit<BiographyState> {
  BiographyCubit() : super(const BiographyState());

  void toggleExpanded() {
    emit(state.copyWith(isExpanded: !state.isExpanded));
  }
}
