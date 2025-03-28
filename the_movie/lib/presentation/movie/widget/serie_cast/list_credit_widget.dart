import 'package:flutter/material.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/configs/assets/app_images.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';

import 'package:the_movie/data/models/credits/credit.dart';

import 'package:the_movie/presentation/detail_cast/screen/detail_cast_screen.dart';

class ListCreditWidget extends StatelessWidget {
  final List<Credit> credit;
  const ListCreditWidget({super.key, required this.credit});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: (credit.isNotEmpty) ? credit.length - 1 : 0,
        itemBuilder: (context, index) {
          final item = credit[index];
          return GestureDetector(
            onTap: () {
              AppNavigator.push(context, DetailCastScreen(id: item.id ?? 0));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 160, // Giảm chiều rộng
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shawdowListView,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            AppImages.getImageUrl(item.profilePath ?? ""),
                            height: 240, // Tăng chiều dài
                            width: double.infinity, // width: height / 1.5
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            item.name ?? '',
                            maxLines: 2, // Giới hạn 2 dòng
                            overflow:
                                TextOverflow.ellipsis, // Hiển thị dấu "..."
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            item.character ?? '',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
