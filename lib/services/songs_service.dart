import 'package:flutter_guid/flutter_guid.dart';
import 'package:lyrics_library/presentation/features/songs/list/models/songs_filter_model.dart';
import '/presentation/features/songs/edit/models/edit_song_model.dart';

import '/presentation/features/songs/create/models/create_song_model.dart';
import '/presentation/features/songs/shared/model/song_model.dart';
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
    SongFilterModel? filters
  }) async {
    return _localSource.fetchSongs(
      page: page,
      filters: filters
    );
  }

  Future<ResponseModel<SongModel>> createSong({
    required CreateSongModel createSongModel,
  }) async {
    return _localSource.createSong(
      createSongModel: createSongModel
    );
  }

  Future<ResponseModel<String>> deleteSongs({
    required List<Guid> songsIds
  }) async {
    return _localSource.deleteSongs(
      songsIds: songsIds
    );
  }

  Future<ResponseModel<SongModel?>> editSong({
    required EditSongModel editSongModel,
  }) async {
    return _localSource.editSong(
      editSongModel: editSongModel
    );
  }

}