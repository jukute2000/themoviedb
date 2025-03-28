import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/movie/bloc/serie_cast/serie_cast_cubit.dart';
import 'package:the_movie/presentation/movie/bloc/serie_cast/serie_cast_state.dart';
import 'package:the_movie/presentation/movie/widget/serie_cast/list_credit_widget.dart';

class SerieCastWidget extends StatefulWidget {
  final int id;
  final bool isMovie;
  const SerieCastWidget({super.key, required this.id, required this.isMovie});

  @override
  State<SerieCastWidget> createState() => _SerieCastWidgetState();
}

class _SerieCastWidgetState extends State<SerieCastWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SerieCastCubit()..loadCredit(widget.id, widget.isMovie),
      child: BlocBuilder<SerieCastCubit, SerieCastState>(
          builder: (context, state) {
        if (state is SerieCastIsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SerieCastError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is SerieCaseLoaded) {
          return ListCreditWidget(credit: state.credits);
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
