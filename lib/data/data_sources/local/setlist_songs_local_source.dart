import 'package:flutter_guid/flutter_guid.dart';
import 'package:lyrics_library/config/config.dart';
import 'package:lyrics_library/utils/db/sqlite.dart';
import 'package:lyrics_library/utils/logger/logger_helper.dart';

import '/data/data_sources/interfaces/setlist_songs_data_source_interface.dart';
import '/presentation/features/setlists/read/model/setlist_song_model.dart';
import '/presentation/features/songs/shared/model/song_model.dart';

//import '/config/config.dart';
//import '/data/data_sources/interfaces/setlists_data_source_interface.dart';
import '/data/models/response_model.dart';
//import '/presentation/features/setlists/create/models/create_setlist_model.dart';
//import '/presentation/features/setlists/edit/models/edit_setlist_model.dart';
//import '/presentation/features/setlists/shared/models/setlist_model.dart';
//import '/utils/db/setlists_table.dart';
//import '/utils/db/sqlite.dart';
//import '/utils/extensions/string_extensions.dart';
//import '/utils/logger/logger_helper.dart';

class SetlistSongsLocalSource extends SetlistSongsDataSource {
  SetlistSongsLocalSource({required super.sessionService});

  @override
  Future<ResponseModel<List<SetlistSongModel>?>> fetchsSongsBySetlistId({
    required Guid setlistId, 
    required String query
  }) async {

    try {
      final setlistSongsList = await SQLite.instance.rawQuery(
        'SELECT S.id as id, '
        'S.title as title, '
        'G.name as genreName '
        'FROM ${SetlistSongsTable.name} as SS JOIN ${SongsTable.name} as S ON '
        'SS.${SetlistSongsTable.colSongId} = S.${SongsTable.colId} '
        'LEFT JOIN ${GenresTable.name} as G ON '
        'S.${SongsTable.colGenreId} = G.${GenresTable.colId} '
        'WHERE SS.${SetlistSongsTable.colSetlistId} = ? '
        "AND S.title LIKE '%$query%' ",
        [setlistId.toString()]
      );
      await Future.delayed(Config.manualLocalServicesDelay);
      final setlistSongs = SetlistSongModel.fromMapList(setlistSongsList);

      return ResponseModel(
        success: true,
        model: setlistSongs
      );
    } catch (e) {

      Log.y('🤡 ${e.toString()}');
      Log.y('😭 Error en SetlistSongsLocalSource método [fetchsSongsBySetlistId]');

      return ResponseModel(
        success: false,
        message: 'Ocurrió un probelma al obtener las canciones'
      );
      
    }
   
  }

  @override
  Future<ResponseModel<SongModel?>> addSongsToSetlist() {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<String>> deleteSongsFromSetlist({
    required List<Guid> songsIds
  }) {
    throw UnimplementedError();
  }
 

}