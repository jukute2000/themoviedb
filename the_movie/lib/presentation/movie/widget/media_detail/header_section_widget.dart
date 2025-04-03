import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/configs/assets/app_images.dart';

class HeaderSection extends StatelessWidget {
  final String backdropPath;
  final String posterPath;

  const HeaderSection(
      {super.key, required this.backdropPath, required this.posterPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.containerNavBar,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          _buildBackdropImage(),
          _buildPosterImage(),
        ],
      ),
    );
  }

  Widget _buildBackdropImage() {
    return Image.network(
      AppImages.getImageBackdrop(backdropPath),
      width: double.infinity,
      height: 200.h,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Image.asset(
        AppImages.noImage,
        width: double.infinity,
        height: 200.h,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildPosterImage() {
    return Positioned(
      left: 16.w,
      bottom: 16.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.network(
          AppImages.getImagePoster(posterPath),
          width: 80.w,
          height: 120.h,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Image.asset(
            AppImages.noImage,
            width: 80.w,
            height: 120.h,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
