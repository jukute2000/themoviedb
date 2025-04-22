import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/data/models/chat/chat_room.dart';
import 'package:the_movie/presentation/firebase/detail/detail_chat_screen.dart';
import 'package:the_movie/presentation/firebase/home/home/bloc/home_cubit.dart';
import 'package:the_movie/presentation/firebase/home/home/bloc/home_state.dart';
import 'package:the_movie/presentation/firebase/widgets/item_chat_base_widget.dart';

class TabContact extends StatelessWidget {
  const TabContact({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeLoaded) {
          if (state.auths == null) {
            return const Center(child: Text('No authentication available'));
          }
          return ListView.builder(
            padding: EdgeInsets.all(PaddingSizes.p8),
            itemCount: state.auths!.length,
            itemBuilder: (context, index) {
              final auth = state.auths![index];
              return ItemChatBaseWidget(
                onTap: () async {
                  ChatRoom chatRoom =
                      await cubit.createChatRoom([auth.id!], state.chatRooms);

                  AppNavigator.push(
                      context,
                      DetailChatScreen(
                        chatRoomId: chatRoom.chatId!,
                        name: cubit.checkNameUser(auth.name),
                      ));
                },
                nameLeading: auth.firstCharName(),
                title: auth.name ?? "Unknow",
              );
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
