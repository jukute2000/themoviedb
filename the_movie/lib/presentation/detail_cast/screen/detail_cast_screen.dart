import 'package:flutter/material.dart';
import 'package:the_movie/presentation/widgets/appbar_widget.dart';
import 'package:the_movie/presentation/detail_cast/widget/detail_cast.dart';

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
          title: const Text("Thông báo"),
          content:
              const Text("Chào mừng bạn đến với trang thông tin diễn viên"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
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
      ),
    );
  }
}
