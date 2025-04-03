import 'package:flutter/material.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/data/models/account/account_model.dart';

class ProfileDetailWidget extends StatelessWidget {
  final AccountModel accountModel;
  const ProfileDetailWidget({super.key, required this.accountModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      decoration: const BoxDecoration(color: AppColors.containerProfile),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Avatar
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.backgroundProfile,
                child: Text(
                  'L',
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Tên người dùng
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                accountModel.username,
                style: const TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            // Thành viên từ
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Thành viên kể từ March 2025',
                style: TextStyle(
                  color: AppColors.textWhite70,
                  fontSize: 14,
                ),
              ),
            ),

            // Điểm số
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScoreWidget(score: 50, label: 'Điểm phim'),
                  SizedBox(width: 40),
                  ScoreWidget(score: 75, label: 'Điểm TV'),
                ],
              ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
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
                    score >= 75
                        ? AppColors.ratingGreen
                        : AppColors.ratingYellow,
                  ),
                ),
              ),
              Text(
                '$score*',
                style: const TextStyle(
                  color: AppColors.textWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              'Trung bình\n$label',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textWhite70,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
