import 'package:lyrics_library/presentation/features/songs/create/models/create_song_model.dart';
import 'package:lyrics_library/presentation/features/songs/shared/model/song_model.dart';

import '/presentation/features/songs/list/models/songs_list_model.dart';
import '/data/data_sources/local/songs_local_source.dart';
import '/data/data_sources/api/songs_api_source.dart';
import '/data/models/response_model.dart';

class SongsService{
  //final SongsApiSource _apiSource;
  final SongsLocalSource _localSource;

  SongsService({
    required SongsApiSource apiSource,
    required SongsLocalSource localSource
  })
  :
  //_apiSource = apiSource;
  _localSource = localSource;

  Future<ResponseModel<SongsListModel>> fetchSongs({
    required int page,
  }) async {
    return _localSource.fetchSongs(
      page: page,
    );
  }

  Future<ResponseModel<SongModel>> createSong({
    required CreateSongModel createSongModel,
  }) async {
    return _localSource.createSong(
      createSongModel: createSongModel
    );
  }


}