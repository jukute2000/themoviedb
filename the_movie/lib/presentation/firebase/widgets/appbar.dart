import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/core/utils/text_manager.dart';

import '../../theme/screen/app_style_provider.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({
    super.key,
    required this.body,
    required this.name,
  });

  final Widget body;
  final String name;
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          pinned: true,
          backgroundColor: AppStyleProvider.of(context).backgroundColor(),
          title: Text(
            name.length < 17 ? name : "${name.substring(0, 16)}...",
            overflow: TextOverflow.ellipsis,
            style: TextManager.textStyleBlod(TextSizes.s32).copyWith(
              color: AppStyleProvider.of(context).iconColor(),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.all(PaddingSizes.p12),
              child: CircleAvatar(
                backgroundColor: AppStyleProvider.of(context).iconColor(),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    FirebaseAuth.instance.currentUser!.displayName!
                        .split('')
                        .first,
                    style: TextManager.textStyleBlod(32.sp).copyWith(
                      color: AppStyleProvider.of(context).textColor(),
                    ),
                  ),
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
