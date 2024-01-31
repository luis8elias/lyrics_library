import 'package:flutter_guid/flutter_guid.dart';
import 'package:lyrics_library/presentation/features/setlist_songs/add/models/song_model_from_add_song_to_setlist_model.dart';
import 'package:lyrics_library/presentation/features/setlist_songs/list/model/setlist_song_model.dart';
import 'package:lyrics_library/presentation/features/setlist_songs/list/model/setlist_song_order_model.dart';
import '/presentation/features/songs/shared/model/song_model.dart';

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

  Future<ResponseModel<ListAddSongs?>> fetchSongsToAddToSetlist({
    required Guid setlistId, 
    required String query,
    required page,
  }) async{
    return _localSource.fetchSongsToAddToSetlist(
      setlistId: setlistId, 
      query: query,
      page: page,
    );
  }

  Future<ResponseModel<SongModel?>> toogleIsFavorite({
    required SongModel songModel,
  }) async {
    return _localSource.toogleIsFavorite(
      songModel: songModel
    );
  }

  Future<ResponseModel> orderSongs({
    required List<SetlistSongOrderModel> songsOrdered,
  }) async {
    return _localSource.orderSongs(
      songsOrdered: songsOrdered
    );
  }

  Future<ResponseModel<String>> deleteSongs({
    required List<Guid> songsIds,
    required Guid setlistId
  }) async {
    return _localSource.deleteSongsFromSetlist(
      songsIds: songsIds,
      setlistId: setlistId
    );
  }

  Future<ResponseModel<SetlistSongModel?>> addSongToSetlist({
    required Guid songId,
    required Guid setlistId,
  })async {
    return _localSource.addSongToSetlist(
      songId: songId,
      setlistId: setlistId
    );
  }

  
}