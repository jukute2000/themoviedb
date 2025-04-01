import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/home/widgets/appbar_widget.dart';
import 'package:the_movie/presentation/home/widgets/title_widget.dart';
import 'package:the_movie/presentation/profile/bloc/profile_detail/profile_detail_cubit.dart';
import 'package:the_movie/presentation/profile/bloc/profile_detail/profile_detail_state.dart';
import 'package:the_movie/presentation/profile/widgets/movies_favourites_widget.dart';
import 'package:the_movie/presentation/profile/widgets/profile_detail.dart';
import 'package:the_movie/presentation/profile/widgets/profile_detail_widget.dart';
import 'package:the_movie/presentation/profile/widgets/tivi_favourites_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileDetail(),
            TitleWidget(
              title: "Movies Favourites",
              fontSize: 28,
            ),
            MoviesFavouritesWidget(),
            TitleWidget(
              title: "Tivi Favourites",
              fontSize: 28,
            ),
            TiviFavouritesWidget(),
          ],
        ),
      ),
    );
  }
}
