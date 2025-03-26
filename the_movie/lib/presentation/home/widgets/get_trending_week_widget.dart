import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:the_movie/data/models/medias/movie.dart';
import 'package:the_movie/data/models/medias/tv.dart';
import 'package:the_movie/presentation/home/bloc/trending/trending_week_cubit.dart';
import 'package:the_movie/presentation/home/bloc/trending/trending_week_state.dart';

class GetTrendingWeekWidget extends StatefulWidget {
  const GetTrendingWeekWidget({super.key});

  @override
  State<GetTrendingWeekWidget> createState() => _GetTrendingWeekWidgetState();
}

class _GetTrendingWeekWidgetState extends State<GetTrendingWeekWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrendingWeekCubit()..loadMedias(),
      child: BlocBuilder<TrendingWeekCubit, TrendingWeekState>(
          builder: (context, state) {
        if (state is TrendingWeekIsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TrendingWeekError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is MediasTrendingWeekLoaded) {
          return Container(
            height: 340,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.medias.length - 1,
              itemBuilder: (context, index) {
                final item = state.medias[index];
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
                                "https://media.themoviedb.org/t/p/w440_and_h660_face/${item.posterPath}",
                                height: 240, // Tăng chiều dài
                                width: double.infinity, // width: height / 1.5
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              left: 8,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: (item.voteAverage >= 7.5)
                                      ? Colors.green
                                      : Colors.amber[700],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  "${(item.voteAverage * 10).round().toString()}%",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (item is Movie)
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item.title,
                                  maxLines: 2, // Giới hạn 2 dòng
                                  overflow: TextOverflow
                                      .ellipsis, // Hiển thị dấu "..."
                                  style: TextStyle(
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
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          )
                        else if (item is TiVi)
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item.name,
                                  maxLines: 2, // Giới hạn 2 dòng
                                  overflow: TextOverflow
                                      .ellipsis, // Hiển thị dấu "..."
                                  style: TextStyle(
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
                                      .format(item.firstAirDate!)
                                      .toString(),
                                  style: TextStyle(
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
