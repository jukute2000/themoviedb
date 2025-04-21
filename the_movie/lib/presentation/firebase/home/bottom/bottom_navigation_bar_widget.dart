import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/firebase/home/bottom/bloc/bottom_navigator_cubit.dart';
import 'package:the_movie/presentation/firebase/home/bottom/bloc/bottom_navigator_state.dart';
import 'package:the_movie/presentation/theme/screen/app_style_provider.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigatorCubit, BottomNavigatorIndex>(
        builder: (context, state) {
      return BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Tin nhắn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Danh bạ',
          ),
        ],
        selectedItemColor: AppStyleProvider.of(context).iconColor(),
        currentIndex: state.index,
        onTap: (index) {
          context.read<BottomNavigatorCubit>().changeIndex(index);
        },
      );
    });
  }
}
