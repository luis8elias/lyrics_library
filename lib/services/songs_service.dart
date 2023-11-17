import '/data/data_sources/api/songs_api_source.dart';
import '/data/models/response_model.dart';

class SongsService{
  final SongsApiSource _apiSource;

  SongsService({required SongsApiSource apiSource})
  :_apiSource = apiSource;

   Future<ResponseModel<List<String>?>> fetchSongs({
    required int page,
  }) async {
    return _apiSource.fetchSongs(
      page: page,
    );
  }


}