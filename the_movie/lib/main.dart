import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// <<<<<<< HEAD
import 'package:flutter_svg/svg.dart';
import 'package:the_movie/presentation/auth/screen/login_screen.dart';
import 'package:the_movie/presentation/demo/demo.dart';
import 'package:the_movie/presentation/demo/demo_cubit.dart';
import 'package:the_movie/presentation/demo_detail/demo_detail_cubit.dart';
import 'package:the_movie/presentation/detail_search/screen/detail_search_screen.dart';
import 'package:the_movie/presentation/splash/bloc/splash_cubit.dart';
import 'package:the_movie/presentation/splash/screen/splash_screen.dart';

// =======
// import 'package:the_movie/presentation/demo/demo.dart';
// import 'package:the_movie/presentation/demo/demo_cubit.dart';
// >>>>>>> feature/list_view

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DemoCubit(),
          ),
          BlocProvider(
            create: (context) => DemoDetailCubit(),
          )
          // BlocProvider(
          //   create: (context) => SplashCubit()..appStarted(),
          // ),
        ],
        child: ScreenUtilInit(
            designSize: getDesignSize(),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                  locale: context.locale,
                  supportedLocales: context.supportedLocales,
                  localizationsDelegates: context.localizationDelegates,
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    colorScheme:
                        ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                    useMaterial3: true,
                  ),
                  home: DetailSearchScreen());
            }));
  }
}

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 13, 81, 136),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          _createDrawerItem(Icons.favorite, "Favorites"),
          _createDrawerItem(Icons.group, "Friends"),
          _createDrawerItem(Icons.share, "Share"),
          _createDrawerItem(Icons.notifications, "Request"),
          Divider(),
          _createDrawerItem(Icons.settings, "Settings"),
          _createDrawerItem(Icons.policy, "Policies"),
          Divider(),
          _createDrawerItem(Icons.exit_to_app, "Exit"),
        ],
      )),
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: const Color.fromARGB(255, 55, 194, 194)),
        backgroundColor: Color.fromARGB(255, 13, 81, 136),
        title: SvgPicture.network(
          'https://www.themoviedb.org/assets/2/v4/logos/v2/blue_short-8e7b30f73a4020692ccca9c88bafe5dcb6f8a62a4c6bc55cd9ba82bb2cd95f6c.svg',
          height: 18,
          color: const Color.fromARGB(255, 55, 194, 194),
          // Chiều cao của logo
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.person,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Phần chào mừng với ô tìm kiếm
            Stack(
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
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
                  color:
                      const Color.fromARGB(255, 43, 109, 127).withOpacity(0.5),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome.",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Millions of movies, TV shows and people to discover. Explore now.",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Search...",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.search, color: Colors.blue),
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
            Padding(
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
            HorizontalListView(),
            Padding(
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
            HorizontalListView(),
          ],
        ),
      ),
    );
  }

  ListTile _createDrawerItem(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: () {
        // Xử lý sự kiện khi nhấn vào mục
        print("Clicked on $text");
      },
    );
  }
}

class SwitchButton extends StatefulWidget {
  @override
  _SwitchButtonState createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool isTodaySelected = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blueGrey, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isTodaySelected = true;
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isTodaySelected ? Colors.blueGrey : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Today",
                style: TextStyle(
                  color: isTodaySelected ? Colors.cyanAccent : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isTodaySelected = false;
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: !isTodaySelected ? Colors.blueGrey : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "This Week",
                style: TextStyle(
                  color: !isTodaySelected ? Colors.cyanAccent : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HorizontalListView extends StatelessWidget {
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

Size getDesignSize() {
  double width = WidgetsBinding
          .instance.platformDispatcher.views.first.physicalSize.width /
      WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

  if (width < 600) {
    return const Size(430, 932); // Mobile
  } else if (width < 1100) {
    return const Size(768, 1024); // Tablet
  } else {
    return const Size(1200, 800); // Web/Desktop
  }
}
