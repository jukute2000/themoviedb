import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:the_movie/presentation/home/bloc/popular/popular_cubit.dart';
import 'package:the_movie/presentation/home/bloc/popular/popular_state.dart';

class GetPopularWidget extends StatefulWidget {
  const GetPopularWidget({super.key});

  @override
  State<GetPopularWidget> createState() => _GetPopularWidgetState();
}

class _GetPopularWidgetState extends State<GetPopularWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PopularCubit()..loadMovie(),
      child: BlocBuilder<PopularCubit, PopularState>(builder: (context, state) {
        if (state is PopularIsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PopularError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is MoviePopularLoaded) {
          return Container(
            height: 340,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.movies.length - 1,
              itemBuilder: (context, index) {
                final item = state.movies[index];
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
                          offset: const Offset(0, 4),
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
                              // xử lý lỗi đường dẫn, tạo widget chung cho hình ảnh, constant đường dẫn
                              child: Image.network(
                                "https://media.themoviedb.org/t/p/w440_and_h660_face/${item.posterPath}",
                                height: 240, // Tăng chiều dài
                                width: double.infinity, // width: height / 1.5
                                fit: BoxFit.cover,
                              ),
                            ),
                            // nên tách thành các widget nhỏ hơn
                            Positioned(
                              bottom: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: (item.voteAverage >= 8.0)
                                      ? Colors.green
                                      : Colors.amber[700],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  // tạo function ở trong model để xử lý => ở UI chỉ cần gọi function - tái sử dụng
                                  "${(item.voteAverage * 10).round().toString()}%",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item.title,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                DateFormat('MMM dd, yyyy')
                                    .format(item.releaseDate!)
                                    .toString(),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
