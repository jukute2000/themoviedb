import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/models/author/author.dart';
import 'package:the_movie/data/models/keyword/keyword.dart';
import 'package:the_movie/data/models/media_detail/detail_media/detail_movie.dart';
import 'package:the_movie/data/models/media_detail/detail_media/detail_tv.dart';
import 'package:the_movie/data/models/medias/movie.dart';
import 'package:the_movie/data/models/medias/tv.dart';

import 'package:the_movie/data/models/people/people_detail.dart';
import 'package:the_movie/data/models/release_date/release_date.dart';
import 'package:the_movie/data/models/search/search_companies.dart';
import 'package:the_movie/data/models/search/search_keywords.dart';
import 'package:the_movie/data/models/search/search_movie.dart';
import 'package:the_movie/data/models/search/search_multi.dart';
import 'package:the_movie/data/models/search/search_tv.dart';
import 'package:the_movie/data/models/video/video.dart';
import 'package:the_movie/data/repositories/people_repository.dart';
import 'package:the_movie/data/repositories/search_repository.dart';
import 'package:the_movie/presentation/demo_detail/demo_detail_state.dart';
import '../../data/models/credits/credit.dart';

import '../../data/models/search/search_collections.dart';
import '../../data/models/search/search_people.dart';
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
      Review review = await MediaDetailRepositoryImpl.intance
          .getReview(id: id, isMovie: isMovie);
      print("review ${review.author.length}");
      List<SearchMulti> searchMulties =
          await SearchRepositoryImpl.intance.getSearchMutil("a");
      print("search multi : ${searchMulties.length}");
      SearchMovie searchMovie =
          await SearchRepositoryImpl.intance.getSearchMovies("a", 1);
      print("search movie : ${searchMovie.results?.length}");
      SearchTv searchTv =
          await SearchRepositoryImpl.intance.getSearchTv("a", 1);
      print("search tv : ${searchTv.results?.length}");
      SearchPeople searchPeople =
          await SearchRepositoryImpl.intance.getSearchPeople("a", 1);
      print("search people : ${searchPeople.peoples?.length}");
      SearchCompanies searchCompanies =
          await SearchRepositoryImpl.intance.getSearchCompany("a", 1);
      print("search companies: ${searchCompanies.companies?.length}");
      SearchKeywords searchKeywords =
          await SearchRepositoryImpl.intance.getSearchKeywords("a", 1);
      print("search keyword: ${searchKeywords.keywords?.length}");
      SearchCollections searchCollections =
          await SearchRepositoryImpl.intance.getSearchCollections("a", 1);
      print("search collection: ${searchCollections.collections?.length}");
      PeopleDetail peopleDetail =
          await PeopleRepositoryImpl.intance.getPeopleDetail(id: 976);
      print(peopleDetail.name);
    } catch (e) {
      emit(Error("Error: $e"));
    }
  }
}
