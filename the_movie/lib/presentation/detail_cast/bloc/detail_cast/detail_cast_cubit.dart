import 'package:collection/collection.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/core/comons/extension/media_type_enum.dart';
import 'package:the_movie/data/models/medias/media.dart';
import 'package:the_movie/data/models/people/people_detail.dart';
import 'package:the_movie/presentation/detail_cast/bloc/detail_cast/detail_cast._state.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../data/models/credits/combined_credit.dart/combined_credit.dart';
import '../../../../data/models/credits/combined_credit.dart/crew.dart';
import '../../../../data/models/credits/external.dart';
import '../../../../data/models/credits/social_media.dart';
import '../../../../data/models/medias/movie.dart';
import '../../../../data/models/medias/tv.dart';
import '../../../../data/repositories/people_repository.dart';

class DetailCastCubit extends Cubit<DetailCastState> {
  DetailCastCubit() : super(DetailCastInitial());
  Map<String, List<Crew>> originalCrews = {};
  List<Media> originalMedias = [];
  bool isClear = false;
  Future<void> loadDetailCast(int id) async {
    if (!isClosed) emit(DetailCastIsLoading());
    try {
      PeopleDetail? peopleDetail =
          await PeopleRepositoryImpl.intance.getPeopleDetail(id: id);
      External? external =
          await PeopleRepositoryImpl.intance.getExternal(id: id);
      List<Movie>? movies =
          await PeopleRepositoryImpl.intance.getKnowFor(id: id);
      CombinedCredit? credits =
          await PeopleRepositoryImpl.intance.getAllCredits(id: id);
      if (credits?.crew != null) {
        originalCrews = groupBy(
            credits!.crew ?? [], (Crew crew) => crew.department!)
          ..forEach((_, list) =>
              list.sort((a, b) => b.getDateTime().compareTo(a.getDateTime())));
      }

      if (credits?.cast != null) {
        originalMedias = (credits!.cast ?? [])
          ..sort((a, b) => (b.getReleaseDate() ?? DateTime(0))
              .compareTo(a.getReleaseDate() ?? DateTime(0)));
      }

      if (!isClosed) {
        emit(DetailCastLoaded(
          detailPeople: peopleDetail,
          external: external,
          movies: movies,
          crews: originalCrews,
          medias: originalMedias,
        ));
      }
    } catch (e) {
      if (!isClosed) emit(DetailCastError("Error: $e"));
    }
  }

  void filterCrewByDepartment(String department) {
    if (state is DetailCastLoaded) {
      final currentState = state as DetailCastLoaded;
      isClear = true;
      if (!isClosed) {
        emit(currentState.copyWith(
          crews: {department: originalCrews[department] ?? []},
          medias: [],
        ));
      }
    }
  }

  void filterCast(MediaTypeEnum mediaType) {
    if (state is DetailCastLoaded) {
      final currentState = state as DetailCastLoaded;
      isClear = true;

      if (!isClosed) {
        emit(currentState.copyWith(
          crews: {},
          medias: mediaType == MediaTypeEnum.movie
              ? originalMedias.whereType<Movie>().toList()
              : originalMedias.whereType<TiVi>().toList(),
        ));
      }
    }
  }

  void resetFilter() {
    if (state is DetailCastLoaded) {
      final currentState = state as DetailCastLoaded;
      isClear = false;
      if (!isClosed) {
        emit(currentState.copyWith(
          crews: originalCrews,
          medias: originalMedias,
        ));
      }
    }
  }

  Future<void> openSocialMedia(SocialMedia socialMedia) async {
    bool isInstall = await LaunchApp.isAppInstalled(
        androidPackageName: socialMedia.pageName);
    if (isInstall) {
      LaunchApp.openApp(androidPackageName: socialMedia.pageName);
    } else {
      Uri webUrl = Uri.parse("${socialMedia.baseUrl}${socialMedia.id}");
      launchUrl(webUrl);
    }
  }
}
