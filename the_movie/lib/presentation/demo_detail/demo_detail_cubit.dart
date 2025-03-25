import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/models/keywords/keywords.dart';
import 'package:the_movie/data/models/media_detail/detail_movie.dart';
import 'package:the_movie/data/models/media_detail/detail_tv.dart';
import 'package:the_movie/data/models/medias/movie.dart';
import 'package:the_movie/data/models/medias/tv.dart';
import 'package:the_movie/presentation/demo_detail/demo_detail_state.dart';
import '../../data/models/credits/credit.dart';
import '../../data/repositories/media_detail_repository.dart';

class DemoDetailCubit extends Cubit<DemoDetailStateCubit> {
  DemoDetailCubit() : super(Initial());
  final MediaDetailRepository _detailRepository = MediaDetailRepository();

  void loadMedia(int id, bool isMovie) async {
    emit(IsLoading());
    try {
      if (isMovie) {
        DetailMovie movie = await _detailRepository.getMovieDetail(id);
        List<Movie> movies =
            await _detailRepository.getMovieRecommendations(id);
        List<Credit> credits =
            await _detailRepository.getCredits(id: id, isMovie: isMovie);
        List<Keywords> keywords =
            await _detailRepository.getKeywords(id: id, isMovie: isMovie);
        emit(MovieDetail(
            movie: movie, mvRe: movies, credits: credits, keywords: keywords));
      } else {
        DetailTv tv = await _detailRepository.getTVDetail(id);
        List<TiVi> tvRe = await _detailRepository.getTvRecommendations(id);
        List<Credit> credits =
            await _detailRepository.getCredits(id: id, isMovie: isMovie);
        List<Keywords> keywords =
            await _detailRepository.getKeywords(id: id, isMovie: isMovie);
        emit(
            TvDetail(tv: tv, tvRe: tvRe, credits: credits, keywords: keywords));
      }
    } catch (e) {
      emit(Error("Error: $e"));
    }
  }
}
