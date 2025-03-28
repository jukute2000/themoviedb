import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/models/credits/external.dart';
import 'package:the_movie/data/models/credits/combined_credit.dart/combined_credit.dart';
import 'package:the_movie/data/models/keyword/keyword.dart';
import 'package:the_movie/data/models/media_detail/detail_media/detail_movie.dart';
import 'package:the_movie/data/models/media_detail/detail_media/detail_tv.dart';
import 'package:the_movie/data/models/medias/movie.dart';
import 'package:the_movie/data/models/medias/tv.dart';
import 'package:the_movie/data/models/release_date/release_date.dart';
import 'package:the_movie/data/models/video/video.dart';
import 'package:the_movie/data/repositories/people_repository.dart';
import 'package:the_movie/presentation/demo_detail/demo_detail_state.dart';
import '../../data/models/credits/credit.dart';
import '../../data/repositories/media_detail_repository.dart';

class DemoDetailCubit extends Cubit<DemoDetailStateCubit> {
  DemoDetailCubit() : super(Initial());

  void loadMedia(int id, bool isMovie) async {
    emit(IsLoading());
    try {
      if (isMovie) {
        DetailMovie movie =
            await MediaDetailRepositoryImpl.intance.getMovieDetail(id);
        List<Movie> movies =
            await MediaDetailRepositoryImpl.intance.getMovieRecommendations(id);
        List<Credit> credits = await MediaDetailRepositoryImpl.intance
            .getCredits(id: id, isMovie: isMovie);
        List<Keyword> keywords = await MediaDetailRepositoryImpl.intance
            .getKeywords(id: id, isMovie: isMovie);
        List<Video> videos = await MediaDetailRepositoryImpl.intance
            .getVideos(id: id, isMovie: isMovie);
        ReleaseDates releaseDates =
            await MediaDetailRepositoryImpl.intance.getReleaseDates(id: id);
        print(releaseDates.releaseDates?.length);
        emit(MovieDetail(
            movie: movie,
            mvRe: movies,
            credits: credits,
            keywords: keywords,
            videos: videos));
      } else {
        DetailTv tv = await MediaDetailRepositoryImpl.intance.getTVDetail(id);
        List<TiVi> tvRe =
            await MediaDetailRepositoryImpl.intance.getTvRecommendations(id);
        List<Credit> credits = await MediaDetailRepositoryImpl.intance
            .getCredits(id: id, isMovie: isMovie);
        List<Keyword> keywords = await MediaDetailRepositoryImpl.intance
            .getKeywords(id: id, isMovie: isMovie);
        List<Video> videos = await MediaDetailRepositoryImpl.intance
            .getVideos(id: id, isMovie: isMovie);
        emit(TvDetail(
            tv: tv,
            tvRe: tvRe,
            credits: credits,
            keywords: keywords,
            videos: videos));
      }
      CombinedCredit combinedCredit =
          await PeopleRepositoryImpl.intance.getAllCredits(id: 976);
      print(
          'Cast ${combinedCredit.cast?.length} - Crew ${combinedCredit.crew?.length}');
      External ex = await PeopleRepositoryImpl.intance.getExternal(id: 976);
      print("External ${ex.facebookId}");
    } catch (e) {
      emit(Error("Error: $e"));
    }
  }
}
