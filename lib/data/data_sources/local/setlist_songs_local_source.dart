import 'package:flutter_guid/flutter_guid.dart';

import '/config/config.dart';
import '/data/data_sources/interfaces/setlist_songs_data_source_interface.dart';
import '/presentation/features/setlists/add_song/models/add_song_to_setlist_model.dart';
import '/presentation/features/setlists/read/model/setlist_song_model.dart';
import '/presentation/features/setlists/shared/models/setlist_model.dart';
import '/presentation/features/songs/shared/model/song_model.dart';
import '/utils/db/sqlite.dart';
import '/utils/logger/logger_helper.dart';
import '/data/models/response_model.dart';


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
        'G.name as genreName, '
        'SS.indexOrder as indexOrder '
        'FROM ${SetlistSongsTable.name} as SS JOIN ${SongsTable.name} as S ON '
        'SS.${SetlistSongsTable.colSongId} = S.${SongsTable.colId} '
        'LEFT JOIN ${GenresTable.name} as G ON '
        'S.${SongsTable.colGenreId} = G.${GenresTable.colId} '
        'WHERE SS.${SetlistSongsTable.colSetlistId} = ? '
        "AND S.title LIKE '%$query%'"
        'ORDER BY SS.indexOrder ASC',
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

   @override
  Future<ResponseModel<SongModel?>> toogleIsFavorite({
    required SongModel songModel
  }) async{

    final authModel = await sessionService.getAuthModel();
    final isFavorite = songModel.isFavoriteAsBool;

    try {
      
      final newValue = songModel.isFavoriteAsBool ? 0 : 1;
      await Future.delayed(Config.manualLocalServicesDelay);

      final setlists = await SQLite.instance.query(
        SetlistsTable.name,
        where: '${SetlistsTable.colIsAllowToRemove} = ? ',
        whereArgs: [0]
      );
      final setlistModel = SetlistModel.fromMap(setlists[0]);

      final batch = SQLite.instance.batch();
      batch.update(
        SongsTable.name,
        {SongsTable.colIsFavorite: newValue},
        where: '${SongsTable.colId} = ?', 
        whereArgs: [songModel.id.toString()]
      );
      if(isFavorite){
        batch.delete(
          SetlistSongsTable.name, 
          where: '${SetlistSongsTable.colSongId} = ? AND '
          '${SetlistSongsTable.colSetlistId} = ?',
          whereArgs: [
            songModel.id.toString(),
            setlistModel.id.toString()
          ]
        );
      }else{

        final addSongToSetlist = AddSongToSetListModel(
          id: Guid.newGuid, 
          setlistId: setlistModel.id, 
          songId: songModel.id, 
          ownerId: authModel?.userId ?? ''
        );

        batch.insert(
          SetlistSongsTable.name,
          addSongToSetlist.toMap(),
        );
      }

      await batch.commit();

      return ResponseModel(
        success: true, 
        message: 'Canción editada' ,
        model: songModel.copyWith(
          isFavorite: isFavorite ? 0 : 1
        )
      );
      

    } catch (e) {

      Log.y('🤡 ${e.toString()}');
      Log.y('😭 Error en SongsLocalSource método [toogleIsFavorite]');

      return ResponseModel(
        success: false,
        message: isFavorite 
        ? 'Ocurrió un problema al remover de favoritos'
        : 'Ocurrió un problema al agregar a favoritos'
      );
      
    }
  }
}