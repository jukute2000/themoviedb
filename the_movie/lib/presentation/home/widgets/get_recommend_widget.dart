import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/home/bloc/recomened/recommened_cubit.dart';
import 'package:the_movie/presentation/home/bloc/recomened/recommened_state.dart';
import 'package:the_movie/presentation/home/widgets/listview_detail_widget.dart';

class GetRecommendWidget extends StatefulWidget {
  const GetRecommendWidget({super.key});

  @override
  State<GetRecommendWidget> createState() => _GetRecommendWidgetState();
}

class _GetRecommendWidgetState extends State<GetRecommendWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecommenedCubit()..loadRecommened(),
      child: BlocBuilder<RecommenedCubit, RecommenedState>(
          builder: (context, state) {
        if (state is RecommenedIsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is RecommenedError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is RecommenedLoaded) {
          return ListviewDetailWidget(
            detailMedia: state.listMediaDetail,
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
