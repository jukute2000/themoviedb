import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        _buildIconButton(Icons.list, false, () {
          print("List icon tapped");
        }),
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
        padding: const EdgeInsets.only(right: 5, bottom: 5),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blueGrey[900],
            shape: BoxShape.circle,
          ),
          child:
              Icon(icon, color: isChosse ? Colors.red : Colors.white, size: 20),
        ),
      ),
    );
  }
}
