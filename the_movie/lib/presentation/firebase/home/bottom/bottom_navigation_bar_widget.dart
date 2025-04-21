import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/firebase/home/bottom/bloc/bottom_navigator_cubit.dart';
import 'package:the_movie/presentation/firebase/home/bottom/bloc/bottom_navigator_state.dart';
import 'package:the_movie/presentation/theme/screen/app_style_provider.dart';

import '../../../../core/configs/assets/app_strings.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigatorCubit, BottomNavigatorIndex>(
        builder: (context, state) {
      return BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.chat),
            label: AppStrings.chat.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.people),
            label: AppStrings.contact.tr(),
          ),
        ],
        selectedItemColor: AppStyleProvider.of(context).iconColor(),
        currentIndex: state.index,
        onTap: (index) {
          context.read<BottomNavigatorCubit>().changeIndex(index);
        },
      );
    });
  }
}
