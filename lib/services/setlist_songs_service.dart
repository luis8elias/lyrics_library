import 'package:flutter_guid/flutter_guid.dart';
import 'package:lyrics_library/presentation/features/songs/shared/model/song_model.dart';

import '/presentation/features/setlists/read/model/setlist_song_model.dart';
import '/data/models/response_model.dart';
import '/data/data_sources/local/setlist_songs_local_source.dart';

class SetlistSongsService {
  final SetlistSongsLocalSource _localSource;

  SetlistSongsService({
    required SetlistSongsLocalSource localSource
  }) : _localSource = localSource;

  Future<ResponseModel<List<SetlistSongModel>?>> fetchsSongsBySetlistId({
    required Guid setlistId, 
    required String query
  }){
    return _localSource.fetchsSongsBySetlistId(
      setlistId: setlistId, 
      query: query
    );
  }

  Future<ResponseModel<SongModel?>> toogleIsFavorite({
    required SongModel songModel,
  }) async {
    return _localSource.toogleIsFavorite(
      songModel: songModel
    );
  }

  
}