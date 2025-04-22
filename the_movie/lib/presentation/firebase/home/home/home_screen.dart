import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/presentation/firebase/home/bottom/bloc/bottom_navigator_cubit.dart';
import 'package:the_movie/presentation/firebase/home/bottom/bloc/bottom_navigator_state.dart';
import 'package:the_movie/presentation/firebase/home/home/bloc/home_cubit.dart';
import 'package:the_movie/presentation/firebase/home/home/group_contact.dart';
import 'package:the_movie/presentation/firebase/home/home/tab_chat.dart';
import 'package:the_movie/presentation/firebase/home/home/tab_contact.dart';
import 'package:the_movie/presentation/firebase/widgets/appbar.dart';
import 'package:the_movie/presentation/firebase/home/bottom/bottom_navigation_bar_widget.dart';
import 'package:the_movie/presentation/theme/screen/app_style_provider.dart';

import '../../../../core/configs/navigation/app_navigation.dart';

//tạo funcion để kiểm tra listUser có trong listUser của ChatRoom hay không nếu có thì mở chatroom còn không thì tạo chatroom mới
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    return BlocProvider<BottomNavigatorCubit>(
      create: (context) => BottomNavigatorCubit(),
      child: Scaffold(
        body: AppbarWidget(
          body: BlocBuilder<BottomNavigatorCubit, BottomNavigatorIndex>(
            builder: (context, state) {
              return IndexedStack(
                index: state.index,
                children: const [
                  TabChat(),
                  TabContact(),
                ],
              );
            },
          ),
          name: 'Home Screen',
        ),
        bottomNavigationBar: const BottomNavigationBarWidget(),
        floatingActionButton:
            BlocBuilder<BottomNavigatorCubit, BottomNavigatorIndex>(
                builder: (context, state) {
          if (state.index == 1) {
            return FloatingActionButton(
              backgroundColor: AppColors.backgroundWhite,
              onPressed: () {
                AppNavigator.push(context, GroupContact(homeCubit: homeCubit));
              },
              child: Icon(
                Icons.add,
                color: AppStyleProvider.of(context).iconColor(),
              ),
            );
          } else {
            return const SizedBox();
          }
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
