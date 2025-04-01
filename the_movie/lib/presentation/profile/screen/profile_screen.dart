import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/profile/bloc/profile_detail/profile_detail_cubit.dart';
import 'package:the_movie/presentation/profile/bloc/profile_detail/profile_detail_state.dart';
import 'package:the_movie/presentation/profile/widgets/profile_detail_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileDetailCubit()..loadProfileDetails(),
      child: BlocBuilder<ProfileDetailCubit, ProfileDetailState>(
          builder: (context, state) {
        if (state is ProfileDetailIsLoading) {
          return const Center(
            //set height = list widget.
            child: CircularProgressIndicator(),
          );
        } else if (state is ProfileDetailError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is AccountProfileDetailLoaded) {
          return ProfileDetailWidget(accountModel: state.accountModel);
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
