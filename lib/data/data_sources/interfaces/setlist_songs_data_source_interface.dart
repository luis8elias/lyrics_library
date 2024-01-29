import 'package:flutter_guid/flutter_guid.dart';

import '/data/models/response_model.dart';
import '/presentation/features/setlist_songs/list/model/setlist_song_model.dart';
import '/presentation/features/setlist_songs/list/model/setlist_song_order_model.dart';
import '/presentation/features/songs/shared/model/song_model.dart';
import '/services/session_service.dart';

abstract class SetlistSongsDataSource{

  final SessionService sessionService;

  SetlistSongsDataSource({required this.sessionService});

  Future<ResponseModel<List<SetlistSongModel>?>> fetchsSongsBySetlistId({
    required Guid setlistId,
    required String query
  });
  
  Future<ResponseModel<SongModel?>> addSongsToSetlist();

  Future<ResponseModel<String>> deleteSongsFromSetlist({
    required List<Guid> songsIds
  });

  Future<ResponseModel<SongModel?>> toogleIsFavorite({
    required SongModel songModel
  });

  Future<ResponseModel> orderSongs({
    required List<SetlistSongOrderModel> songsOrdered,
  });

  Future<ResponseModel<String>> deleteSongs({
    required List<Guid> songsIds,
    required Guid setlistId
  });
 

}