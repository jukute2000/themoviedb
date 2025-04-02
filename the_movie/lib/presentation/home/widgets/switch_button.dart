import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/presentation/home/bloc/switch/switch_cubit.dart';

class SwitchButton extends StatelessWidget {
  const SwitchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwitchCubit, bool>(
      builder: (context, isTodaySelected) {
        return Container(
          padding: EdgeInsets.all(PaddingSizes.p4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blueGrey, width: 1.5.w),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => context.read<SwitchCubit>().selectToday(),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 8.w),
                  decoration: BoxDecoration(
                    color:
                        isTodaySelected ? Colors.blueGrey : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Today",
                    style: TextStyle(
                      color: isTodaySelected ? Colors.cyanAccent : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => context.read<SwitchCubit>().selectThisWeek(),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 8.w),
                  decoration: BoxDecoration(
                    color:
                        !isTodaySelected ? Colors.blueGrey : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "This Week",
                    style: TextStyle(
                      color:
                          !isTodaySelected ? Colors.cyanAccent : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
