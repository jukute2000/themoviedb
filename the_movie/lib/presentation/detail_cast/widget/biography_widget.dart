import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/detail_cast/bloc/biography/biography_cubit.dart';
import 'package:the_movie/presentation/detail_cast/bloc/biography/biography_state.dart';

class BiographyWidget extends StatelessWidget {
  final String fullText;
  const BiographyWidget({super.key, required this.fullText});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BiographyCubit(),
      child: BlocBuilder<BiographyCubit, BiographyState>(
        builder: (context, state) {
          String displayedText =
              state.isExpanded ? fullText : '${fullText.substring(0, 200)}...';

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: displayedText,
                style: const TextStyle(
                    fontStyle: FontStyle.italic, color: Colors.black),
                children: [
                  TextSpan(
                    text: state.isExpanded ? " View Less" : " View More",
                    style: const TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.read<BiographyCubit>().toggleExpanded();
                      },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
