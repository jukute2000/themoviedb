import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/home/bloc/trending/trending_cubit.dart';
import 'package:the_movie/presentation/home/bloc/trending/trending_state.dart';
import 'package:the_movie/presentation/home/widgets/listview_widget.dart';

class GetTrenddingWidget extends StatefulWidget {
  const GetTrenddingWidget({super.key});

  @override
  State<GetTrenddingWidget> createState() => _GetTrenddingWidgetState();
}

class _GetTrenddingWidgetState extends State<GetTrenddingWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrendingCubit()..loadMedias(),
      child:
          BlocBuilder<TrendingCubit, TrendingState>(builder: (context, state) {
        if (state is TrendingIsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TrendingError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is MediasTrendingLoaded) {
          return ListviewWidget(medias: state.medias);
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
