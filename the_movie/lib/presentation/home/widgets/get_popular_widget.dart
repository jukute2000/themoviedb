import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/home/bloc/popular/popular_cubit.dart';
import 'package:the_movie/presentation/home/bloc/popular/popular_state.dart';
import 'package:the_movie/presentation/home/widgets/listview_widget.dart';

class GetPopularWidget extends StatefulWidget {
  const GetPopularWidget({super.key});

  @override
  State<GetPopularWidget> createState() => _GetPopularWidgetState();
}

class _GetPopularWidgetState extends State<GetPopularWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PopularCubit()..loadMovie(),
      child: BlocBuilder<PopularCubit, PopularState>(builder: (context, state) {
        if (state is PopularIsLoading) {
          return const Center(
            //set height = list widget.
            child: CircularProgressIndicator(),
          );
        } else if (state is PopularError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is MoviePopularLoaded) {
          return ListviewWidget(medias: state.movies);
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
