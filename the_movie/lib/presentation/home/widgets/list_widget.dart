import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  final List<Map<String, String>> items = [
    {
      'image':
          'https://media.themoviedb.org/t/p/w440_and_h660_face/jRdxyW5ZmhD3ycStlb7gwOewTuE.jpg',
      'title': 'Thăng cấp một mình',
      'date': 'Jan 07, 2024',
      'rating': '86%',
    },
    {
      'image':
          'https://media.themoviedb.org/t/p/w440_and_h660_face/jRdxyW5ZmhD3ycStlb7gwOewTuE.jpg',
      'title': 'Biến cố tuổi thành niên',
      'date': 'Mar 13, 2025',
      'rating': '77%',
    },
    {
      'image':
          'https://media.themoviedb.org/t/p/w440_and_h660_face/jRdxyW5ZmhD3ycStlb7gwOewTuE.jpg',
      'title': 'Xứ sở rô-bốt',
      'date': 'Mar 14, 2025',
      'rating': '67%',
    },
    {
      'image':
          'https://media.themoviedb.org/t/p/w440_and_h660_face/jRdxyW5ZmhD3ycStlb7gwOewTuE.jpg',
      'title': 'Thăng cấp một mình',
      'date': 'Jan 07, 2024',
      'rating': '86%',
    },
  ];

  ListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 160, // Giảm chiều rộng
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
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
                          item['image']!,
                          height: 240, // Tăng chiều dài
                          width: double.infinity, // width: height / 1.5
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            item['rating']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      item['title']!,
                      maxLines: 2, // Giới hạn 2 dòng
                      overflow: TextOverflow.ellipsis, // Hiển thị dấu "..."
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      item['date']!,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
