import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/core/utils/text_manager.dart';
import 'package:the_movie/data/repositories/chat/chat_repository.dart';
import 'package:the_movie/presentation/firebase/home/screen/home/bloc/home_cubit.dart';
import 'package:the_movie/presentation/firebase/home/screen/home/bloc/home_state.dart';

import '../../../../../core/configs/assets/app_colors.dart';
import '../../../detail/detail_chat_screen.dart';

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
                    final name = context
                        .read<HomeCubit>()
                        .nameChatRoom(chatRoom, state.auths!);
                    final bgColor = AppColors.getRandomColor();
                    final textColor = AppColors.getTextColor(bgColor);
                    return ListTile(
                      onTap: () => AppNavigator.push(
                        context,
                        DetailChatScreen(
                          chatRoomId: chatRoom.chatId!,
                        ),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: bgColor,
                        child: Text(
                          name[0],
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        name[1],
                        style: TextManager.textStyleMedium(18.sp),
                      ),
                      subtitle: StreamBuilder(
                        stream: ChatRepositoryImpl.instance
                            .getLastMessage(chatRoom.chatId!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return const Text('Error loading message');
                          }
                          if (!snapshot.hasData) {
                            return const Text('No messages yet');
                          }
                          final lastMessage = snapshot.data;
                          return Text(
                            lastMessage?.message ?? 'No message',
                            style: TextManager.textStyleRegular(14.sp),
                          );
                        },
                      ),
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
