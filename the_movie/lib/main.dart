import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/assets/app_theme.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/presentation/auth/bloc/auth_movie_cubit.dart';
import 'package:the_movie/presentation/firebase/auth/bloc/auth_cubit.dart';
import 'package:the_movie/presentation/home/bloc/locale/locale_cubit.dart';
import 'package:the_movie/presentation/theme/bloc/theme_state.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_collection/bloc/tab_collection_cubit.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_company/bloc/tab_company_cubit.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_keyword/bloc/tab_keyword_cubit.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_movie/bloc/tab_movie_cubit.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_people/bloc/tab_people_cubit.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_tv_show/bloc/tab_tv_show_cubit.dart';
import 'package:the_movie/presentation/detail_search/stream_controller/search_total_provider.dart';
import 'package:the_movie/presentation/home/bloc/recomened/recommened_cubit.dart';
import 'package:the_movie/presentation/profile/bloc/profile_detail/profile_detail_cubit.dart';
import 'package:the_movie/presentation/splash/screen/splash_screen.dart';
import 'package:the_movie/presentation/theme/screen/app_style_provider.dart';
import 'presentation/firebase/home/home/bloc/home_cubit.dart';
import 'presentation/theme/bloc/theme_cubit.dart';

void main() {
  runApp(const MyApp());
}

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchTotalProvider(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LocaleCubit()),
          BlocProvider(
            create: (context) => ProfileDetailCubit(),
          ),
          BlocProvider(create: (_) => RecommenedCubit()),
          BlocProvider<TabMovieCubit>(create: (context) => TabMovieCubit()),
          BlocProvider<TabTvShowCubit>(create: (context) => TabTvShowCubit()),
          BlocProvider<TabCollectionCubit>(
              create: (context) => TabCollectionCubit()),
          BlocProvider(create: (context) => TabCompanyCubit()),
          BlocProvider(create: (context) => TabKeywordCubit()),
          BlocProvider(create: (context) => TabPeopleCubit()),
          BlocProvider(create: (context) => ThemeCubit()),
          BlocProvider(create: (context) => AuthCubit()),
          BlocProvider(create: (context) => AuthMovieCubit()),
          BlocProvider<HomeCubit>(
              create: (context) => HomeCubit()..fetchData()),
        ],
        child: ScreenUtilInit(
          designSize: getDesignSize(),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
              final appStyle = state.isDarkMode ? DarkTheme() : LightTheme();
              return AppStyleProvider(
                style: appStyle,
                child: MaterialApp(
                  navigatorObservers: [routeObserver],
                  navigatorKey: NavigationService.navigatorKey,
                  locale: context.locale,
                  supportedLocales: context.supportedLocales,
                  localizationsDelegates: context.localizationDelegates,
                  debugShowCheckedModeBanner: false,
                  theme: appStyle.themeData,
                  home: const SplashScreen(),
                ),
              );
            });
          },
        ),
      ),
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
