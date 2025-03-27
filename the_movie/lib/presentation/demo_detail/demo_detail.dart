// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:the_movie/presentation/demo_detail/demo_detail_cubit.dart';
// import 'package:the_movie/presentation/demo_detail/demo_detail_state.dart';
//
// class DemoDetail extends StatelessWidget {
//   const DemoDetail({super.key, required this.id, required this.isMovie});
//   final int id;
//   final bool isMovie;
//
//   @override
//   Widget build(BuildContext context) {
//     final DemoDetailCubit demoDetailCubit = context.read<DemoDetailCubit>();
//     demoDetailCubit.loadMedia(id, isMovie);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(isMovie ? "Movie Detail" : "TV Detail"),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: BlocBuilder<DemoDetailCubit, DemoDetailStateCubit>(
//           bloc: demoDetailCubit,
//           builder: (context, state) {
//             if (state is IsLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is Error) {
//               return Center(child: Text(state.message));
//             } else if (state is MovieDetail) {
//               return Center(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("Type : Movie"),
//                     Text("Title : ${state.movie.title}"),
//                     Text("Movie recommendation length: ${state.mvRe.length}"),
//                     Text("Movie credits length: ${state.credits.length}"),
//                     Text("Movie keywords length: ${state.keywords.length}"),
//                     Text("Movie video length: ${state.videos.length}"),
//                   ],
//                 ),
//               );
//             } else if (state is TvDetail) {
//               return Center(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("Type : TV"),
//                     Text("Title : ${state.tv.name}"),
//                     Text("TV recommendation length: ${state.tvRe.length}"),
//                     Text("TV credits length: ${state.credits.length}"),
//                     Text("TV Keywords length: ${state.keywords.length}"),
//                     Text("TV Video length: ${state.videos.length}"),
//                   ],
//                 ),
//               );
//             }
//             return Text("Unknown state");
//           },
//         ),
//       ),
//     );
//   }
// }
