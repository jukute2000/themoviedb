import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchCubit extends Cubit<bool> {
  SwitchCubit() : super(true);

  void selectToday() => emit(true);
  void selectThisWeek() => emit(false);
}
