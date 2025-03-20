import 'package:flutter/material.dart';
import 'package:the_movie/data/models/medias/media.dart';
import 'package:the_movie/data/models/medias/movie.dart';

import '../../core/constants/api.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  late Future<List<Media>> movies;

  @override
  void initState() {
    // TODO: implement initState
    movies = Api().getMoviePopular();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo'),
      ),
      body: FutureBuilder(future: movies, builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError){
          return Center(child: Text('Error'),);
        } else if (!snapshot.hasData) {
          return Center(child: Text('No data'),);
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index].overview),
              );
            },
          );
        }
      })
    );
  }
}
