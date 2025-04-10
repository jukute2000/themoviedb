import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/presentation/movie/bloc/account_status/account_status_cubit.dart';
import 'package:the_movie/presentation/movie/bloc/account_status/account_status_state.dart';
import 'package:the_movie/presentation/movie/widget/infor_icon/infor_icon.dart';

import '../../../../core/utils/text_manager.dart';

class InfoSection extends StatelessWidget {
  final bool isMovie;
  final String releaseDateText;
  final String originText;
  final String runtimeText;
  final String genreText;

  const InfoSection(
      {super.key,
      required this.releaseDateText,
      required this.originText,
      required this.runtimeText,
      required this.genreText,
      required this.isMovie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(PaddingSizes.p16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCertification(),
              GapsManager.w10,
              _buildRuntimeInfo(),
              _buildTrailerButton(),
            ],
          ),
          _buildGenreText(),
        ],
      ),
    );
  }

  Widget _buildCertification() {
    return Container(
      padding: EdgeInsets.all(PaddingSizes.p4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(RadiusSizes.r4),
        border: Border.all(
          color: AppColors.containerCetificate,
          width: 1,
        ),
      ),
      child: Text(
        'PG',
        style: TextManager.textStyleMedium(TextSizes.s16).copyWith(
          color: AppColors.textWhite,
        ),
      ),
    );
  }

  Widget _buildRuntimeInfo() {
    return Expanded(
      child: Text(
        " $releaseDateText ($originText) • $runtimeText",
        style: TextManager.textStyleMedium(TextSizes.s16).copyWith(
          color: AppColors.textWhite,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildTrailerButton() {
    return BlocBuilder<AccountStatusCubit, AccountStatusState>(
      builder: (context, state) {
        if (state is AccountStatusIsLoading) {
          return const CircularProgressIndicator();
        } else if (state is AccountStatusError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is AccountStatusLoaded) {
          return InforIcon(
            accountStatus: state.accountStatus,
            isMovie: isMovie,
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildGenreText() {
    return Text(
      genreText,
      style: TextManager.textStyleMedium(TextSizes.s16).copyWith(
        color: AppColors.textWhite,
      ),
    );
  }
}
