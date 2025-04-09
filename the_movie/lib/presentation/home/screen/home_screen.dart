import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/core/configs/assets/app_strings.dart';
import 'package:the_movie/presentation/widgets/appbar_widget.dart';
import 'package:the_movie/presentation/home/bloc/switch/switch_cubit.dart';
import 'package:the_movie/presentation/home/widgets/banner_widget.dart';
import 'package:the_movie/presentation/home/widgets/drawer_widget.dart';
import 'package:the_movie/presentation/home/widgets/get_popular_widget.dart';
import 'package:the_movie/presentation/home/widgets/get_trendding_widget.dart';
import 'package:the_movie/presentation/home/widgets/get_trending_week_widget.dart';
import 'package:the_movie/presentation/home/widgets/switch_button.dart';
import 'package:the_movie/presentation/home/widgets/title_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: const DrawerWidget(),
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
                const BannerWidget(),
                // Phần Trending
                TitleWidget(
                  title: AppStrings.trending.tr(),
                  widget: const SwitchButton(),
                  fontSize: 28,
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
                  fontSize: 28,
                ),
                const GetPopularWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
