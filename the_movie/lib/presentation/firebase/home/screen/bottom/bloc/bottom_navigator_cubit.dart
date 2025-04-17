import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/firebase/home/screen/bottom/bloc/bottom_navigator_state.dart';

class BottomNavigatorCubit extends Cubit<BottomNavigatorIndex> {
  BottomNavigatorCubit() : super(BottomNavigatorIndex(0));

  void changeIndex(int index) {
    emit(BottomNavigatorIndex(index));
  }
}
