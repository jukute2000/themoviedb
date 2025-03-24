import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/models/medias/movie.dart';
import 'package:the_movie/presentation/demo/demo_cubit.dart';

import '../../data/models/medias/media.dart';
import '../../data/models/medias/tv.dart';
import 'demo_state.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  late DemoCubit demoCubit;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    demoCubit = context.read<DemoCubit>();
    demoCubit.loadMedias();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      demoCubit.loadMedias(isLoadMode: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo"),
        centerTitle: true,
      ),
      body: BlocBuilder<DemoCubit, DemoStateCubit>(builder: (context, state) {
        if (state is IsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is Error) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is Medias) {
          return state.medias == []
              ? Center(
                  child: Text("No data"),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    demoCubit.onRefesh();
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: state.medias.length + 1,
                    itemBuilder: (context, index) {
                      if (index == state.medias.length) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      Media media = state.medias[index];
                      if (media is Movie) {
                        return ListTile(
                          title: Text(media.title),
                          subtitle: Text(media.overview),
                        );
                      } else if (media is TiVi) {
                        return ListTile(
                          title: Text(media.name),
                          subtitle: Text(media.overview),
                        );
                      }
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
