import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/data/models/account/account_status.dart';
import 'package:the_movie/presentation/movie/bloc/account_status/account_status_cubit.dart';

class InforIcon extends StatefulWidget {
  final bool isMovie;
  final AccountStatus accountStatus;
  const InforIcon(
      {super.key, required this.accountStatus, required this.isMovie});

  @override
  State<InforIcon> createState() => _InforIconState();
}

class _InforIconState extends State<InforIcon> {
  late bool isFavorites;
  late bool isWatchList;
  late AccountStatus currentStatus;

  // Future loadingFavorites(context) async {
  //   // loading circle
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return const Center(child: CircularProgressIndicator());
  //     },
  //   );

  //   context
  //       .read<AccountStatusCubit>()
  //       .addToFavorites(currentStatus.id, widget.isMovie, isFavorites);

  //   Navigator.of(context).pop();
  // }

  @override
  void initState() {
    super.initState();
    currentStatus = widget.accountStatus;
    isFavorites = currentStatus.favorite;
    isWatchList = currentStatus.watchlist; // Lưu trữ trạng thái ban đầu
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildIconButton(Icons.list, false, () {}),
        _buildIconButton(Icons.favorite, isFavorites, () {
          setState(() {
            isFavorites = !isFavorites;
          });
          context
              .read<AccountStatusCubit>()
              .addToFavorites(currentStatus.id, widget.isMovie, isFavorites);
        }),
        // hiển thị loading cho đến khi api nó hoàn thành và trả về kết quả
        // nhận state => để tránh user spam ,disable những button liên quan
        // Loading tại nút login
        _buildIconButton(Icons.bookmark, isWatchList, () {
          setState(() {
            isWatchList = !isWatchList;
          });
          context
              .read<AccountStatusCubit>()
              .addToWatchList(currentStatus.id, widget.isMovie, isWatchList);
        }),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, bool isChosse, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 5.w, bottom: 5.h),
        child: Container(
          padding: EdgeInsets.all(PaddingSizes.p8),
          decoration: const BoxDecoration(
            color: AppColors.containerIcon,
            shape: BoxShape.circle,
          ),
          child: Icon(icon,
              color: isChosse ? AppColors.iconChoose : AppColors.iconUnChoose,
              size: 20.w),
        ),
      ),
    );
  }
}
