import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/detail_cast/bloc/detail_cast/detail_cast._state.dart';
import 'package:the_movie/presentation/detail_cast/bloc/detail_cast/detail_cast_cubit.dart';
import 'package:the_movie/presentation/detail_cast/widget/detail_cast_widget.dart';

class DetailCast extends StatelessWidget {
  final int id;
  const DetailCast({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailCastCubit()..loadDetailCast(id),
      child: BlocBuilder<DetailCastCubit, DetailCastState>(
          builder: (context, state) {
        if (state is DetailCastIsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is DetailCastError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is DetailCastLoaded) {
          return DetailCastWidget(
            peopleDetail: state.detailPeople,
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
