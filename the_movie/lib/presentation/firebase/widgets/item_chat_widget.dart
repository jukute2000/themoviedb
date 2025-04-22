import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/assets/app_strings.dart';
import 'package:the_movie/core/utils/text_manager.dart';
import 'package:the_movie/data/repositories/chat/chat_repository.dart';
import 'package:the_movie/presentation/firebase/widgets/item_chat_base_widget.dart';

import '../../../core/configs/assets/app_colors.dart';

class ItemChatWidget extends StatefulWidget {
  const ItemChatWidget(
      {super.key,
      required this.chatId,
      required this.name,
      required this.onTap});
  final String chatId;
  final GestureTapCallback? onTap;
  final List<String>? name;

  @override
  State<ItemChatWidget> createState() => _ItemChatWidgetState();
}

class _ItemChatWidgetState extends State<ItemChatWidget> {
  @override
  Widget build(BuildContext context) {
    return ItemChatBaseWidget(
      onTap: widget.onTap,
      nameLeading: widget.name != null && widget.name!.first.isNotEmpty
          ? widget.name!.first
          : "?",
      title: widget.name != null && widget.name![1].isNotEmpty
          ? widget.name![1]
          : "Unknow",
      subtitleBuilder: StreamBuilder(
        stream: ChatRepositoryImpl.instance.getLastMessage(widget.chatId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text(AppStrings.loading.tr());
          }
          if (snapshot.hasError) {
            return Text(AppStrings.errorLoading.tr());
          }
          final lastMessage = snapshot.data;
          final intSeen = lastMessage?.currentUserSeen() ?? 0;
          return Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text:
                      "${intSeen > 0 ? '($intSeen ${AppStrings.unseen.tr()})' : ''} ${lastMessage?.message ?? AppStrings.message.tr()}",
                  style: TextManager.textStyleRegular(14.sp).copyWith(
                    color:
                        intSeen > 0 ? AppColors.textBlue : AppColors.textGrey,
                  ),
                ),
              ],
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          );
        },
      ),
    );
  }
}
