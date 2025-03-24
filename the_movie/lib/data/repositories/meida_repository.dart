import 'package:the_movie/data/datasources/media_datasource.dart';

import '../models/medias/media.dart';

class MeidaRepository {
  final MediaDatasource _mediaDatasource = MediaDatasource();
  Future<List<Media>> getMediaTrending(int page) async {
    return await _mediaDatasource.getMoviePopular(page);
  }
}
