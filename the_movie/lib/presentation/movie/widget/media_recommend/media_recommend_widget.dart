import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/home/widgets/listview_widget.dart';
import 'package:the_movie/presentation/movie/bloc/media_recommend/media_recommend_cubit.dart';
import 'package:the_movie/presentation/movie/bloc/media_recommend/media_recommend_state.dart';

class MediaRecommendWidget extends StatefulWidget {
  final int id;
  final bool isMovie;
  const MediaRecommendWidget(
      {super.key, required this.id, required this.isMovie});

  @override
  State<MediaRecommendWidget> createState() => _MediaRecommendWidgetState();
}

class _MediaRecommendWidgetState extends State<MediaRecommendWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MediaRecommendCubit()..loadMedia(widget.id, widget.isMovie),
      child: BlocBuilder<MediaRecommendCubit, MediaRecommendState>(
          builder: (context, state) {
        if (state is MediaRecommendIsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MediaRecommendError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is MovieRecommendLoaded) {
          return ListviewWidget(medias: state.listMovie);
        } else if (state is TvRecommendLoaded) {
          return ListviewWidget(medias: state.listTv);
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
