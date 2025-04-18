import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      nameLeading: widget.name?.first ?? "?",
      title: widget.name?[1] ?? "Unknown",
      subtitleBuilder: StreamBuilder(
        stream: ChatRepositoryImpl.instance.getLastMessage(widget.chatId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Đang tải...');
          }
          if (snapshot.hasError) {
            return const Text('Lỗi khi tải tin nhắn');
          }
          final lastMessage = snapshot.data;
          final intSeen = lastMessage?.currentUserSeen() ?? 0;
          return Text(
            "${lastMessage?.message ?? 'No message'} ${intSeen > 0 ? '($intSeen chưa đọc)' : ''}",
            style: TextManager.textStyleRegular(14.sp).copyWith(
              color: intSeen > 0 ? AppColors.textBlue : AppColors.textGrey,
            ),
          );
        },
      ),
    );
  }
}
