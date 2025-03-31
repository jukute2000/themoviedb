import 'package:flutter/material.dart';
import 'package:the_movie/presentation/detail_cast/widget/detail_cast.dart';
import 'package:the_movie/presentation/home/widgets/appbar_widget.dart';

class DetailCastScreen extends StatelessWidget {
  final int id;
  const DetailCastScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(onProfilePressed: () {}),
      body: DetailCast(id: id),
    );
  }
}
