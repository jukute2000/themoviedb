import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/firebase/home/screen/bottom/bloc/bottom_navigator_cubit.dart';
import 'package:the_movie/presentation/firebase/home/screen/bottom/bloc/bottom_navigator_state.dart';
import 'package:the_movie/presentation/firebase/home/screen/home/tab_chat.dart';
import 'package:the_movie/presentation/firebase/home/screen/home/tab_contact.dart';
import 'package:the_movie/presentation/firebase/widgets/appbar.dart';
import 'package:the_movie/presentation/firebase/home/screen/bottom/bottom_navigation_bar_widget.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomNavigatorCubit(),
        ),
        // BlocProvider(
        //   create: (context) => HomeCubit()..fetchData(),
        // ),
      ],
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
          ), name: 'Home Screen',
        ),
        bottomNavigationBar: const BottomNavigationBarWidget(),
      ),
    );
  }
}
