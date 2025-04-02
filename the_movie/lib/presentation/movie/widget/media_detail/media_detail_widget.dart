import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/presentation/movie/bloc/account_status/account_status_cubit.dart';
import 'package:the_movie/presentation/movie/bloc/media_detail/media_detail_cubit.dart';
import 'package:the_movie/presentation/movie/bloc/media_detail/media_detail_state.dart';
import 'package:the_movie/presentation/movie/widget/media_detail/detail_widget.dart';

class MediaDetailWidget extends StatelessWidget {
  final int id;
  final bool isMovie;

  const MediaDetailWidget({super.key, required this.id, required this.isMovie});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MediaDetailCubit()..loadMedia(id, isMovie),
        ),
        BlocProvider(
          create: (context) =>
              AccountStatusCubit()..loadAccountStatus(id, isMovie),
        ),
      ],
      child: BlocBuilder<MediaDetailCubit, MediaDetailState>(
          builder: (context, state) {
        if (state is MediaDetailIsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MediaDetailError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is MovieDetailLoaded) {
          return DetailWidget(detailMedia: state.detailMovie);
        } else if (state is TvDetailLoaded) {
          return DetailWidget(detailMedia: state.detailTv);
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppColors.divider,
      thickness: 2,
      height: 20.h,
    );
  }
}
