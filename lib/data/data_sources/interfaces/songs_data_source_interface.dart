import 'package:flutter_guid/flutter_guid.dart';

import '/data/models/response_model.dart';
import '/presentation/features/songs/create/models/create_song_model.dart';
import '/presentation/features/songs/edit/models/edit_song_model.dart';
import '/presentation/features/songs/list/models/songs_list_model.dart';
import '/presentation/features/songs/shared/model/song_model.dart';
import '/services/session_service.dart';

abstract class SongsDataSource{

  final SessionService sessionService;

  SongsDataSource({required this.sessionService});

  Future<ResponseModel<SongsListModel>> fetchSongs({
    required int page,
    //required SongsFilterModel filterModel
  });

  Future<ResponseModel<SongModel>> createSong({
    required CreateSongModel createSongModel,
  });

  Future<ResponseModel<String>> deleteSongs({
    required List<Guid> songsIds
  });

  Future<ResponseModel<SongModel?>> editSong({
    required EditSongModel editSongModel
  });
  

}