import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/core/utils/text_manager.dart';
import 'package:the_movie/presentation/firebase/home/screen/home/bloc/home_cubit.dart';
import 'package:the_movie/presentation/firebase/home/screen/home/bloc/home_state.dart';
import 'package:the_movie/presentation/theme/screen/app_style_provider.dart';

class GroupContact extends StatefulWidget {
  const GroupContact({super.key});

  @override
  State<GroupContact> createState() => _GroupContactState();
}

class _GroupContactState extends State<GroupContact> {
  final List<String> selectedIds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Group Contact',
          style: TextManager.textStyleBlod(36.sp).copyWith(
            color: AppStyleProvider.of(context).iconColor(),
          ),
        ),
        backgroundColor: AppStyleProvider.of(context).backgroundColor(),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            return Stack(
              children: [
                state.auths == null
                    ? const Center(child: Text('No authentication available'))
                    : ListView.builder(
                        padding: const EdgeInsets.only(
                            bottom:
                                80), // Add padding to show items above the button
                        itemCount: state.auths!.length,
                        itemBuilder: (context, index) {
                          final auth = state.auths![index];
                          final bgColor = AppColors.getRandomColor();
                          final textColor = AppColors.getTextColor(bgColor);
                          final initial =
                              auth.name?.substring(0, 1).toUpperCase() ?? '?';
                          final isSelected = selectedIds.contains(auth.id);

                          return Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color.fromARGB(77, 114, 114, 217)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            margin: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: ListTile(
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
                              trailing: Checkbox(
                                value: isSelected,
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      if (!selectedIds.contains(auth.id)) {
                                        selectedIds.add(auth.id!);
                                      }
                                    } else {
                                      selectedIds.remove(auth.id);
                                    }
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                // Done button at bottom
                if (selectedIds.isNotEmpty)
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle the done action with selectedIds
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Selected IDs: ${selectedIds.join(", ")}'),
                          ),
                        );
                        context.read<HomeCubit>().createChatRoom(
                              context,
                              selectedIds,
                              state.chatRooms,
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            AppStyleProvider.of(context).backgroundColor(),
                        padding: EdgeInsets.all(PaddingSizes.p16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        'Done (${selectedIds.length})',
                        style: TextManager.textStyleMedium(16.sp).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          } else if (state is HomeError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
