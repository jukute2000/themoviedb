import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/firebase/home/screen/home/bloc/home_cubit.dart';
import 'package:the_movie/presentation/firebase/home/screen/home/bloc/home_state.dart';

class TabChat extends StatelessWidget {
  const TabChat({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeLoaded) {
          return state.chatRooms == null
              ? const Center(child: Text('No chat rooms available'))
              : ListView.builder(
                  itemCount: state.chatRooms!.length,
                  itemBuilder: (context, index) {
                    final chatRoom = state.chatRooms![index];
                    return ListTile();
                  },
                );
        } else if (state is HomeError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }
}
