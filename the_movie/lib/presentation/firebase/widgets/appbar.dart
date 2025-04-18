import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/utils/text_manager.dart';

import '../../theme/screen/app_style_provider.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({
    super.key,
    required ScrollController scrollController,
    required this.body, required this.name,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final Widget body;
  final String name;
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          pinned: true,
          backgroundColor: AppStyleProvider.of(context).backgroundColor(),
          title: Text(
            name,
            style: TextManager.textStyleBlod(36.sp).copyWith(
              color: AppStyleProvider.of(context).iconColor(),
            ),
          ),
          actions: [
            CircleAvatar(
              backgroundColor: AppStyleProvider.of(context).iconColor(),
              child: Text(
                FirebaseAuth.instance.currentUser!.displayName!.split('').first,
                style: TextManager.textStyleBlod(32.sp).copyWith(
                  color: AppStyleProvider.of(context).textColor(),
                ),
              ),
            ),
          ],
        ),
      ],
      body: body,
    );
  }
}
