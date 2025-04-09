import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/movie/bloc/key_word/key_word_cubit.dart';
import 'package:the_movie/presentation/movie/bloc/key_word/key_word_state.dart';
import 'package:the_movie/presentation/movie/widget/key_word/key_word_widget.dart';

class KeyWord extends StatefulWidget {
  final int id;
  final bool isMovie;
  const KeyWord({super.key, required this.id, required this.isMovie});

  @override
  State<KeyWord> createState() => _KeyWordState();
}

class _KeyWordState extends State<KeyWord> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          KeyWordCubit()..loadKeyWord(widget.id, widget.isMovie),
      child: BlocBuilder<KeyWordCubit, KeyWordState>(builder: (context, state) {
        if (state is KeyWordIsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is KeyWordError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is KeyWordLoaded) {
          return KeyWordWidget1(keywords: state.listKeyWord);
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
