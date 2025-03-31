import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/models/credits/combined_credit.dart/combined_credit.dart';
import 'package:the_movie/data/models/credits/external.dart';
import 'package:the_movie/data/models/medias/media.dart';
import 'package:the_movie/data/models/people/people_detail.dart';
import 'package:the_movie/data/repositories/people_repository.dart';
import 'package:the_movie/presentation/detail_cast/bloc/detail_cast/detail_cast._state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/models/credits/combined_credit.dart/crew.dart';
import '../../../../data/models/medias/movie.dart';
import '../../../../data/models/medias/tv.dart';

class DetailCastCubit extends Cubit<DetailCastState> {
  DetailCastCubit() : super(DetailCastInitial());
  late Map<String, List<Crew>> crews;
  late List<Media> medias;
  Future<void> loadDetailCast(int id) async {
    emit(DetailCastIsLoading());
    try {
      final PeopleDetail peopleDetail =
          await PeopleRepositoryImpl.intance.getPeopleDetail(id: id);
      final External external =
          await PeopleRepositoryImpl.intance.getExternal(id: id);
      final List<Movie> movies =
          await PeopleRepositoryImpl.intance.getKnowFor(id: id);
      final CombinedCredit credits =
          await PeopleRepositoryImpl.intance.getAllCredits(id: id);
      if (credits.crew != null) {
        crews = groupCrewByDepartment(credits.crew!);
        crews.forEach(
          (key, value) {
            value.sort(
              (a, b) => b.getDateTime().compareTo(a.getDateTime()),
            );
          },
        );
      }
      if (credits.cast != null) {
        medias = credits.cast!;
        medias.sort((a, b) {
          DateTime dateA = getReleaseDate(a) ?? DateTime(0);
          DateTime dateB = getReleaseDate(b) ?? DateTime(0);
          return dateB.compareTo(dateA);
        });
      }
      emit(DetailCastLoaded(
          detailPeople: peopleDetail,
          external: external,
          movies: movies,
          crews: crews,
          medias: medias));
    } catch (e) {
      emit(DetailCastError("Error: $e"));
    }
  }

  DateTime? getReleaseDate(Media media) {
    if (media is Movie) {
      return media.releaseDate;
    } else if (media is TiVi) {
      return media.firstAirDate;
    }
    return null;
  }

  Map<String, List<Crew>> groupCrewByDepartment(List<Crew> crewList) {
    return groupBy(crewList, (crew) => crew.department!);
  }

  Future<void> lauchURL(String base, String url) async {
    Uri uri = Uri.parse("$base$url");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print("Không thể mở URL: $uri");
    }
  }
}
