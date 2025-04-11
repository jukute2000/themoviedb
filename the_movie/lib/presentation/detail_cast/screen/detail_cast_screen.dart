import 'package:flutter/material.dart';
import 'package:the_movie/presentation/widgets/appbar_widget.dart';
import 'package:the_movie/presentation/detail_cast/widget/detail_cast.dart';

import '../../../core/configs/assets/app_colors.dart';
import '../../../core/utils/sizes_manager.dart';
import '../../../core/utils/text_manager.dart';
import '../../../initial/remote_confic.dart';

class DetailCastScreen extends StatefulWidget {
  final int id;
  const DetailCastScreen({super.key, required this.id});

  @override
  State<DetailCastScreen> createState() => _DetailCastScreenState();
}

class _DetailCastScreenState extends State<DetailCastScreen> {
  late ScrollController scrollController;
  @override
  void initState() {
    scrollController = ScrollController();
    checkRemoteConfic();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> checkRemoteConfic() async {
    if (await RemoteConfic.instance.getWelcomDetail()) {
      showPromotionDialog();
    }
  }

  void showPromotionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.textWhite,
          title: Text("Thông báo",
              style: TextManager.textStyleBlod(TextSizes.s24).copyWith(
                color: AppColors.textBlack,
              )),
          content: Text("Chào mừng bạn đến với trang thông tin diễn viên",
              style: TextManager.textStyleMedium(TextSizes.s18).copyWith(
                color: AppColors.textBlack,
              )),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK",
                  style: TextManager.textStyleMedium(TextSizes.s18).copyWith(
                    color: AppColors.textBlack,
                  )),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppbarWidget(
          scrollController: scrollController,
          body: DetailCast(id: widget.id),
          isHome: false,
          isSearch: false),
    );
  }
}
