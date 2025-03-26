import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/models/keyword/keyword.dart';
import 'package:the_movie/data/models/media_detail/detail_movie.dart';
import 'package:the_movie/data/models/media_detail/detail_tv.dart';
import 'package:the_movie/data/models/medias/movie.dart';
import 'package:the_movie/data/models/medias/tv.dart';
import 'package:the_movie/data/models/search/search_companies.dart';
import 'package:the_movie/data/models/search/search_keywords.dart';
import 'package:the_movie/data/models/video/video.dart';
import 'package:the_movie/data/repositories/search_repository.dart';
import 'package:the_movie/presentation/demo_detail/demo_detail_state.dart';
import '../../data/models/credits/credit.dart';
import '../../data/models/search/search_collections.dart';
import '../../data/models/search/search_people/search_people.dart';
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
        SearchCollections search = await SearchRepositoryImpl.intance
            .getSearchCollections("action", 1);
        print(search.collections.length);
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
        SearchCollections search = await SearchRepositoryImpl.intance
            .getSearchCollections("action", 1);
        print(search.collections.length);
        emit(TvDetail(
            tv: tv,
            tvRe: tvRe,
            credits: credits,
            keywords: keywords,
            videos: videos));
      }
    } catch (e) {
      emit(Error("Error: $e"));
    }
  }
}
