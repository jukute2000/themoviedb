import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/models/medias/media.dart';
import 'package:the_movie/presentation/detail_cast/bloc/detail_cast/detail_cast._state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/models/credits/combined_credit.dart/crew.dart';
import '../../../../data/models/medias/movie.dart';
import '../../../../data/models/medias/tv.dart';
import '../../../../data/repositories/people_repository.dart';

class DetailCastCubit extends Cubit<DetailCastState> {
  DetailCastCubit() : super(DetailCastInitial());

  Map<String, List<Crew>> originalCrews = {};
  List<Media> originalMedias = [];

  Future<void> loadDetailCast(int id) async {
    emit(DetailCastIsLoading());
    try {
      final peopleDetail =
          await PeopleRepositoryImpl.intance.getPeopleDetail(id: id);
      final external = await PeopleRepositoryImpl.intance.getExternal(id: id);
      final movies = await PeopleRepositoryImpl.intance.getKnowFor(id: id);
      final credits = await PeopleRepositoryImpl.intance.getAllCredits(id: id);

      originalCrews = groupBy(
          credits.crew ?? [], (Crew crew) => crew.department!)
        ..forEach((_, list) =>
            list.sort((a, b) => b.getDateTime().compareTo(a.getDateTime())));

      originalMedias = (credits.cast ?? [])
        ..sort((a, b) => (getReleaseDate(b) ?? DateTime(0))
            .compareTo(getReleaseDate(a) ?? DateTime(0)));

      emit(DetailCastLoaded(
        detailPeople: peopleDetail,
        external: external,
        movies: movies,
        crews: originalCrews,
        medias: originalMedias,
      ));
    } catch (e) {
      emit(DetailCastError("Error: $e"));
    }
  }

  void filterCrewByDepartment(String department) {
    if (state is DetailCastLoaded) {
      final currentState = state as DetailCastLoaded;
      emit(currentState.copyWith(
        crews: {department: originalCrews[department] ?? []},
      ));
    }
  }

  void resetFilter() {
    if (state is DetailCastLoaded) {
      final currentState = state as DetailCastLoaded;
      emit(currentState.copyWith(
        crews: originalCrews,
      ));
    }
  }

  DateTime? getReleaseDate(Media media) {
    return (media is Movie)
        ? media.releaseDate
        : (media is TiVi)
            ? media.firstAirDate
            : null;
  }

  Future<void> launchURL(String base, String url) async {
    final uri = Uri.parse("$base$url");
    if (!await canLaunchUrl(uri)) {
      print("Không thể mở URL: $uri");
    } else {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
