import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/presentation/detail_cast/bloc/detail_cast/detail_cast._state.dart';
import 'package:the_movie/presentation/detail_cast/bloc/detail_cast/detail_cast_cubit.dart';
import 'package:the_movie/presentation/detail_cast/widget/credits_cast.dart';
import 'package:the_movie/presentation/detail_cast/widget/detail_cast_widget.dart';
import 'package:the_movie/presentation/detail_cast/widget/known_for_widget.dart';

class DetailCast extends StatelessWidget {
  final int id;
  const DetailCast({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailCastCubit()..loadDetailCast(id),
      child: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<DetailCastCubit, DetailCastState>(
              builder: (context, state) {
            if (state is DetailCastIsLoading) {
              return SizedBox(
                height: 932.h,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is DetailCastError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is DetailCastLoaded) {
              return Column(
                children: [
                  DetailCastWidget(
                    peopleDetail: state.detailPeople,
                    external: state.external,
                  ),
                  KnownForWidget(movies: state.movies),
                  CreditsCast(medias: state.medias, crews: state.crews)
                ],
              );
            } else {
              return const SizedBox();
            }
          }),
        ),
      ),
    );
  }
}
