import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/core/configs/assets/app_images.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/presentation/auth/screen/login_screen.dart';
import 'package:the_movie/presentation/home/screen/home_screen.dart';
import 'package:the_movie/presentation/splash/bloc/splash_cubit.dart';
import 'package:the_movie/presentation/splash/bloc/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..appStarted(),
      child: Scaffold(
        body: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is UnAuthenticated) {
              AppNavigator.pushReplacement(
                  context,
                  LoginScreen(
                    isUpdate: state.checkUpdate,
                  ));
            }
            if (state is Authenticated) {
              AppNavigator.pushReplacement(
                context,
                const HomeScreen(),
              );
            }
          },
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppImages.splashBackground))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
