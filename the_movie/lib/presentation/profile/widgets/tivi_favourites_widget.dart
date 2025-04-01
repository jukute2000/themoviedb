import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/home/widgets/listview_widget.dart';
import 'package:the_movie/presentation/profile/bloc/tivi_favorites/tivi_favourite_cubit.dart';
import 'package:the_movie/presentation/profile/bloc/tivi_favorites/tivi_favourite_state.dart';

class TiviFavouritesWidget extends StatefulWidget {
  const TiviFavouritesWidget({super.key});

  @override
  State<TiviFavouritesWidget> createState() => _TiviFavouritesWidgetState();
}

class _TiviFavouritesWidgetState extends State<TiviFavouritesWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TiviFavouriteCubit()..loadTiviFavourites(),
      child: BlocBuilder<TiviFavouriteCubit, TiviFavouriteState>(
          builder: (context, state) {
        if (state is TiviFavouriteIsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TiviFavouriteError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is TiviFavouriteLoaded) {
          return ListviewWidget(medias: state.tivis);
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
