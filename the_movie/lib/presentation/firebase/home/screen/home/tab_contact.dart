import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/utils/text_manager.dart';
import 'package:the_movie/presentation/firebase/home/screen/home/bloc/home_cubit.dart';
import 'package:the_movie/presentation/firebase/home/screen/home/bloc/home_state.dart';

class TabContact extends StatelessWidget {
  const TabContact({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeLoaded) {
          return state.auths == null
              ? const Center(child: Text('No authentication available'))
              : ListView.builder(
                  itemCount: state.auths!.length,
                  itemBuilder: (context, index) {
                    final auth = state.auths![index];
                    final bgColor = AppColors.getRandomColor();
                    final textColor = AppColors.getTextColor(bgColor);
                    final initial =
                        auth.name?.substring(0, 1).toUpperCase() ?? '?';
                    return ListTile(
                      onTap: () => context
                          .read<HomeCubit>()
                          .createChatRoom(context, [auth.id!], state.chatRooms),
                      title: Text(
                        auth.name ?? 'No name',
                        style: TextManager.textStyleMedium(18.sp),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: bgColor,
                        child: Text(
                          initial,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
