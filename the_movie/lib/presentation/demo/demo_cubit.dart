import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/demo/demo_state.dart';
import '../../data/models/medias/media.dart';
import '../../data/repositories/meida_repository.dart';

class DemoCubit extends Cubit<DemoStateCubit> {
  DemoCubit() : super(Initial());

  final List<Media> _medias = [];
  int _page = 1;
  bool _isLoading = false;

  Future<void> onRefesh() async {
    _medias.clear();
    _page = 1;
    loadMedias();
  }

  void loadMedias({bool isLoadMode = false}) async {
    if (_isLoading) return;
    _isLoading = true;
    if (!isLoadMode) {
      emit(IsLoading());
    }
    try {
      List<Media> newMedias =
          await MeidaRepositoryImpl.intance.getMediaTrending(_page);
      _medias.addAll(newMedias);
      _page++;
      emit(Medias(medias: _medias));
    } catch (e) {
      emit(Error("Error: $e"));
    } finally {
      _isLoading = false;
    }
  }
}
