import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/home/widgets/listview_widget.dart';
import 'package:the_movie/presentation/profile/bloc/movies_favourite/movies_favourite_cubit.dart';
import 'package:the_movie/presentation/profile/bloc/movies_favourite/movies_favourite_state.dart';

class MoviesFavouritesWidget extends StatefulWidget {
  const MoviesFavouritesWidget({super.key});

  @override
  State<MoviesFavouritesWidget> createState() => _MoviesFavouritesWidgetState();
}

class _MoviesFavouritesWidgetState extends State<MoviesFavouritesWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesFavouriteCubit()..loadMoviesFavourites(),
      child: BlocBuilder<MoviesFavouriteCubit, MoviesFavouriteState>(
          builder: (context, state) {
        if (state is MoviesFavouriteIsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MoviesFavouriteError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is MoviesFavouriteLoaded) {
          return ListviewWidget(medias: state.moviess);
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
