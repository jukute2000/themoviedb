import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/presentation/firebase/home/screen/home/bloc/home_cubit.dart';
import 'package:the_movie/presentation/firebase/home/screen/home/bloc/home_state.dart';
import 'package:the_movie/presentation/firebase/home/screen/home/group_contact.dart';
import 'package:the_movie/presentation/firebase/widgets/item_chat_base_widget.dart';

class TabContact extends StatelessWidget {
  const TabContact({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeLoaded) {
          if (state.auths == null) {
            return const Center(child: Text('No authentication available'));
          }
          return Stack(
            children: [
              ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: state.auths!.length,
                itemBuilder: (context, index) {
                  final auth = state.auths![index];
                  return ItemChatBaseWidget(
                    onTap: () => context.read<HomeCubit>().createChatRoom(
                          context,
                          [auth.id!],
                          state.chatRooms,
                        ),
                    nameLeading: auth.firstCharName(),
                    title: auth.name ?? "Unknow",
                  );
                },
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton(
                  onPressed: () {
                    AppNavigator.push(context, const GroupContact());
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          );
        } else if (state is HomeError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }
}
