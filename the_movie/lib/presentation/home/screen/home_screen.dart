import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_movie/presentation/home/bloc/switch/switch_cubit.dart';
import 'package:the_movie/presentation/home/widgets/drawer_widget.dart';
import 'package:the_movie/presentation/home/widgets/get_popular_widget.dart';
import 'package:the_movie/presentation/home/widgets/get_trendding_widget.dart';
import 'package:the_movie/presentation/home/widgets/get_trending_week_widget.dart';
import 'package:the_movie/presentation/home/widgets/switch_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 55, 194, 194)),
        backgroundColor: const Color.fromARGB(255, 13, 81, 136),
        title: SvgPicture.network(
          'https://www.themoviedb.org/assets/2/v4/logos/v2/blue_short-8e7b30f73a4020692ccca9c88bafe5dcb6f8a62a4c6bc55cd9ba82bb2cd95f6c.svg',
          height: 18,
          color: const Color.fromARGB(255, 55, 194, 194),
          // Chiều cao của logo
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => SwitchCubit()..selectToday(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Phần chào mừng với ô tìm kiếm
              Stack(
                children: [
                  Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://th.bing.com/th/id/OIP.SkqMtqcc6_52knAOaV6tAwHaEo?rs=1&pid=ImgDetMain', // Đặt URL ảnh phim ở đây
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 250,
                    color: const Color.fromARGB(255, 43, 109, 127)
                        .withOpacity(0.5),
                  ),
                  Positioned(
                    top: 50,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Welcome.",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "Millions of movies, TV shows and people to discover. Explore now.",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              const Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Search...",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.search,
                                    color: Colors.blue),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Phần Trending
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Trending",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SwitchButton(),
                  ],
                ),
              ),

              BlocBuilder<SwitchCubit, bool>(
                builder: (context, isTodaySelected) {
                  return isTodaySelected
                      ? const GetTrenddingWidget()
                      : const GetTrendingWeekWidget();
                },
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "What's popular",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const GetPopularWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
