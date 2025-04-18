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
    final cubit = context.read<HomeCubit>();
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
                    final name = cubit.nameChatRoom(chatRoom, state.auths!);
                    final displayLetter = name.isNotEmpty ? name[0] : '?';
                    final displayName = name.length > 1 ? name[1] : 'Unknown';
                    final bgColor = AppColors.getRandomColor();
                    final textColor = AppColors.getTextColor(bgColor);

                    return ListTile(
                      onTap: () => AppNavigator.push(
                        context,
                        DetailChatScreen(chatRoomId: chatRoom.chatId!, name: displayName),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: bgColor,
                        child: Text(
                          displayLetter,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        displayName,
                        style: TextManager.textStyleMedium(18.sp),
                      ),
                      subtitle: StreamBuilder(
                        stream: ChatRepositoryImpl.instance
                            .getLastMessage(chatRoom.chatId!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text('Đang tải...');
                          }
                          if (snapshot.hasError) {
                            return const Text('Lỗi khi tải tin nhắn');
                          }
                          if (!snapshot.hasData) {
                            return const Text('Chưa có tin nhắn');
                          }
                          final lastMessage = snapshot.data;
                          final seenList = lastMessage?.seen ?? [];
                          final currentUserSeen = seenList.firstWhere(
                            (e) => e["id"] == cubit.user.uid,
                            orElse: () => {},
                          );
                          final intSeen = currentUserSeen["unseen"];
                          return Text(
                            "${lastMessage?.message ?? 'No message'} ${intSeen > 0 ? '($intSeen chưa đọc)' : ''}",
                            style: TextManager.textStyleRegular(14.sp).copyWith(
                              color: intSeen > 0
                                  ? AppColors.textBlue
                                  : AppColors.textGrey,
                            ),
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
