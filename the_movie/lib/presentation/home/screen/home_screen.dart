import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/core/configs/assets/app_strings.dart';
import 'package:the_movie/presentation/home/bloc/locale/locale_cubit.dart';
import 'package:the_movie/presentation/home/bloc/locale/locale_state.dart';
import 'package:the_movie/presentation/home/bloc/recomened/recommened_cubit.dart';
import 'package:the_movie/presentation/home/bloc/recomened/recommened_state.dart';
import 'package:the_movie/presentation/home/widgets/get_recommend_widget.dart';
import 'package:the_movie/presentation/widgets/appbar_widget.dart';
import 'package:the_movie/presentation/home/bloc/switch/switch_cubit.dart';
import 'package:the_movie/presentation/home/widgets/banner_widget.dart';
import 'package:the_movie/presentation/home/widgets/drawer_widget.dart';
import 'package:the_movie/presentation/home/widgets/get_popular_widget.dart';
import 'package:the_movie/presentation/home/widgets/get_trendding_widget.dart';
import 'package:the_movie/presentation/home/widgets/get_trending_week_widget.dart';
import 'package:the_movie/presentation/home/widgets/switch_button.dart';
import 'package:the_movie/presentation/home/widgets/title_widget.dart';

import '../../../core/utils/sizes_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FocusNode _focusNode = FocusNode();
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    context.read<RecommenedCubit>().loadRecommened();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(builder: (context, state) {
      context.setLocale(state.locale);
      return Scaffold(
        resizeToAvoidBottomInset: true,
        drawer: const DrawerWidget(),
        onDrawerChanged: (status) {
          if (status) {
            _focusNode.unfocus();
          }
        },
        body: AppbarWidget(
          isSearch: false,
          isHome: true,
          scrollController: _scrollController,
          body: BlocProvider(
            create: (context) => SwitchCubit()..selectToday(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //banner
                  BannerWidget(focusNode: _focusNode),
                  BlocBuilder<RecommenedCubit, RecommenedState>(
                      builder: (context, state) {
                    return const SizedBox();
                  }),
                  TitleWidget(
                    title: AppStrings.trending.tr(),
                    widget: const SwitchButton(),
                    fontSize: TextSizes.s24,
                  ),
                  BlocBuilder<SwitchCubit, bool>(
                    builder: (context, isTodaySelected) {
                      return isTodaySelected
                          ? const GetTrenddingWidget()
                          : const GetTrendingWeekWidget();
                    },
                  ),
                  TitleWidget(
                    title: AppStrings.whatPopular.tr(),
                    fontSize: TextSizes.s24,
                  ),
                  const GetPopularWidget(),
                  TitleWidget(
                    title: AppStrings.recommnedForY.tr(),
                    fontSize: TextSizes.s24,
                  ),
                  const GetRecommendWidget(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
