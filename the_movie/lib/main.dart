import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/presentation/demo_detail/demo_detail.dart';

import 'package:the_movie/presentation/demo_detail/demo_detail_cubit.dart';
import 'package:the_movie/presentation/home/screen/home_screen.dart';
import 'package:the_movie/presentation/splash/bloc/splash_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DemoDetailCubit(),
          ),
          BlocProvider(
            create: (context) => SplashCubit()..appStarted(),
          ),
        ],
        child: ScreenUtilInit(
            designSize: getDesignSize(),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                locale: context.locale,
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                home:
                    // const DemoDetail(id: 447273, isMovie: true),
                    const HomeScreen(),
              );
            }));
  }
}

Size getDesignSize() {
  double width = WidgetsBinding
          .instance.platformDispatcher.views.first.physicalSize.width /
      WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

  if (width < 600) {
    return const Size(430, 932); // Mobile
  } else if (width < 1100) {
    return const Size(768, 1024); // Tablet
  } else {
    return const Size(1200, 800); // Web/Desktop
  }
}
