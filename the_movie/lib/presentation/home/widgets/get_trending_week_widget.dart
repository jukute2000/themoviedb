import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/home/bloc/trending/trending_week_cubit.dart';
import 'package:the_movie/presentation/home/bloc/trending/trending_week_state.dart';
import 'package:the_movie/presentation/home/widgets/listview_widget.dart';

class GetTrendingWeekWidget extends StatefulWidget {
  const GetTrendingWeekWidget({super.key});

  @override
  State<GetTrendingWeekWidget> createState() => _GetTrendingWeekWidgetState();
}

class _GetTrendingWeekWidgetState extends State<GetTrendingWeekWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrendingWeekCubit()..loadMedias(),
      child: BlocBuilder<TrendingWeekCubit, TrendingWeekState>(
          builder: (context, state) {
        if (state is TrendingWeekIsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TrendingWeekError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is MediasTrendingWeekLoaded) {
          return ListviewWidget(medias: state.medias);
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
