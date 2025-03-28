import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/presentation/detail_search/screen/detail_search_screen.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_movie/bloc/tab_movie_cubit.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_tv_show/bloc/tab_tv_show_cubit.dart';
import 'package:the_movie/presentation/detail_search/stream_controller/search_total_provider.dart';
import 'package:the_movie/presentation/splash/bloc/splash_cubit.dart';

import 'core/utils/global_context.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchTotalProvider(
      child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => SplashCubit()..appStarted(),
            ),
            BlocProvider<MovieSearchCubit>(
                create: (context) => MovieSearchCubit()),
            BlocProvider<TvSearchCubit>(create: (context) => TvSearchCubit()),
          ],
          child: ScreenUtilInit(
              designSize: getDesignSize(),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return MaterialApp(
                    navigatorKey: GlobalContext.navigatorKey,
                    locale: context.locale,
                    supportedLocales: context.supportedLocales,
                    localizationsDelegates: context.localizationDelegates,
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData(
                      colorScheme:
                          ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                      useMaterial3: true,
                    ),
                    home: DetailSearchScreen(
                      index: 0,
                      query: 'a',
                    ));
              })),
    );
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
