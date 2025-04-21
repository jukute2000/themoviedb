import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/utils/text_manager.dart';
import 'package:the_movie/presentation/firebase/widgets/cricle_avatar_widget.dart';

class ItemChatBaseWidget extends StatelessWidget {
  const ItemChatBaseWidget({
    super.key,
    required this.onTap,
    required this.nameLeading,
    required this.title,
    this.subtitleBuilder,
  });

  final GestureTapCallback? onTap;
  final String nameLeading;
  final String title;
  final Widget? subtitleBuilder;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CricleAvatarWidget(name: nameLeading),
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextManager.textStyleMedium(18.sp),
      ),
      subtitle: subtitleBuilder,
    );
  }
}
