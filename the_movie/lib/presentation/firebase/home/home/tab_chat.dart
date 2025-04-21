import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/presentation/firebase/home/home/bloc/home_cubit.dart';
import 'package:the_movie/presentation/firebase/home/home/bloc/home_state.dart';
import 'package:the_movie/presentation/firebase/widgets/item_chat_widget.dart';
import '../../detail/detail_chat_screen.dart';

class TabChat extends StatelessWidget {
  const TabChat({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeLoaded) {
          return state.chatRooms == null
              ? const Center(child: Text('No chat rooms available'))
              : ListView.builder(
                  padding: EdgeInsets.all(PaddingSizes.p8),
                  itemCount: state.chatRooms!.length,
                  itemBuilder: (context, index) {
                    final chatRoom = state.chatRooms![index];
                    final name = cubit.nameChatRoom(chatRoom, state.auths!);
                    return ItemChatWidget(
                      chatId: chatRoom.chatId!,
                      name: name,
                      onTap: () => AppNavigator.push(
                        context,
                        DetailChatScreen(
                          chatRoomId: chatRoom.chatId!,
                          name: name[1],
                        ),
                      ),
                    );
                  },
                );
        } else if (state is HomeError) {
          return const Center(child: Text("Lỗi kết nối"));
        }
        return const SizedBox();
      },
    );
  }
}
