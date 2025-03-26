import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/core/configs/assets/app_strings.dart';
import 'package:the_movie/presentation/home/bloc/switch/switch_cubit.dart';
import 'package:the_movie/presentation/home/widgets/appbar_widget.dart';
import 'package:the_movie/presentation/home/widgets/banner_widget.dart';
import 'package:the_movie/presentation/home/widgets/drawer_widget.dart';
import 'package:the_movie/presentation/home/widgets/get_popular_widget.dart';
import 'package:the_movie/presentation/home/widgets/get_trendding_widget.dart';
import 'package:the_movie/presentation/home/widgets/get_trending_week_widget.dart';
import 'package:the_movie/presentation/home/widgets/switch_button.dart';
import 'package:the_movie/presentation/home/widgets/title_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: const DrawerWidget(),
      appBar: CustomAppBar(onProfilePressed: () {}),
      body: BlocProvider(
        create: (context) => SwitchCubit()..selectToday(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //banner
              const BannerWidget(),
              // Phần Trending
              const TitleWidget(
                title: AppStrings.trending,
                widget: SwitchButton(),
              ),
              BlocBuilder<SwitchCubit, bool>(
                builder: (context, isTodaySelected) {
                  return isTodaySelected
                      ? const GetTrenddingWidget()
                      : const GetTrendingWeekWidget();
                },
              ),
              const TitleWidget(title: AppStrings.whatPopular),
              const GetPopularWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
