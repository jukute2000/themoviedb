import 'package:flutter/material.dart';
import 'package:the_movie/data/models/account/account_model.dart';
import 'package:the_movie/presentation/home/widgets/appbar_widget.dart';

class ProfileDetailWidget extends StatelessWidget {
  final AccountModel accountModel;
  const ProfileDetailWidget({super.key, required this.accountModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: const Color(0xFF0B2A47), // Màu nền xanh đậm
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Avatar
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.teal,
              child: Text(
                'L',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Tên người dùng
            Text(
              accountModel.username,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            // Thành viên từ
            const Text(
              'Thành viên kể từ March 2025',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            // Điểm số
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScoreWidget(score: 50, label: 'Điểm phim'),
                SizedBox(width: 40),
                ScoreWidget(score: 75, label: 'Điểm TV'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ScoreWidget extends StatelessWidget {
  final int score;
  final String label;

  const ScoreWidget({super.key, required this.score, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: score / 100,
                strokeWidth: 6,
                backgroundColor: Colors.black54,
                valueColor: AlwaysStoppedAnimation<Color>(
                  score >= 75 ? Colors.green : Colors.yellow,
                ),
              ),
            ),
            Text(
              '$score*',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          'Trung bình\n$label',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
