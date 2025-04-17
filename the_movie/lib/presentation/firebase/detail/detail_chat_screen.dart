import 'package:flutter/material.dart';
import 'package:the_movie/presentation/firebase/widgets/appbar.dart';

class DetailChatScreen extends StatefulWidget {
  const DetailChatScreen({super.key, required this.chatRoomId});
  final String chatRoomId;
  @override
  State<DetailChatScreen> createState() => _DetailChatState();
}

class _DetailChatState extends State<DetailChatScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppbarWidget(
        scrollController: _scrollController,
        body: Center(
          child: Text('Detail Chat'),
        ),
      ),
    );
  }
}
