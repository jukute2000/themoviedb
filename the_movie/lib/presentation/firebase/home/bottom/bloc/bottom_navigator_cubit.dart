import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/firebase/home/bottom/bloc/bottom_navigator_state.dart';

class BottomNavigatorCubit extends Cubit<BottomNavigatorIndex> {
  BottomNavigatorCubit() : super(BottomNavigatorIndex(0));

  void changeIndex(int index) {
    if (!isClosed) emit(BottomNavigatorIndex(index));
  }
}
