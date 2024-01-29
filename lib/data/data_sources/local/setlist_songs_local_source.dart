import 'package:flutter_guid/flutter_guid.dart';
import 'package:lyrics_library/presentation/features/setlist_songs/list/model/setlist_song_order_model.dart';

import '/config/config.dart';
import '/data/data_sources/interfaces/setlist_songs_data_source_interface.dart';
import '../../../presentation/features/setlist_songs/add/models/add_song_to_setlist_model.dart';
import '../../../presentation/features/setlist_songs/list/model/setlist_song_model.dart';
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
        'SELECT SS.id as id, '
        'S.id as songId, '
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
        message: 'Ocurrió un problema al obtener las canciones'
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

      final maxOrder = await SQLite.instance.rawQuery(
        'SELECT MAX(${SetlistSongsTable.colIndexOrder}) as max '
        'FROM ${SetlistSongsTable.name} '
        'WHERE ${SetlistSongsTable.colSetlistId} = ? ',
        [setlistModel.id.toString()]
      );

      final newIndex = maxOrder[0]['max'] as int? ?? 0;

      final addSongToSetlist = AddSongToSetListModel(
        id: Guid.newGuid, 
        setlistId: setlistModel.id, 
        songId: songModel.id, 
        ownerId: authModel?.userId ?? '',
        indexOrder: newIndex + 1
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
      Log.y('😭 Error en SetlistSongsLocalSource método [toogleIsFavorite]');

      return ResponseModel(
        success: false,
        message: isFavorite 
        ? 'Ocurrió un problema al remover de favoritos'
        : 'Ocurrió un problema al agregar a favoritos'
      );
      
    }
  }

  @override
  Future<ResponseModel> orderSongs({
    required List<SetlistSongOrderModel> songsOrdered
  }) async{
    try {

      final batch = SQLite.instance.batch();

      for (var sS in songsOrdered) {
        batch.update(
          SetlistSongsTable.name,
          {SetlistSongsTable.colIndexOrder: sS.indexOrder},
          where: '${SetlistSongsTable.colId} = ?', 
          whereArgs: [sS.setlistSongId.toString()]
        );
      }

      await batch.commit();

      return ResponseModel(
        success: true, 
        message: 'Canciones ordenadas' ,
      );
      
    } catch (e) {

      Log.y('🤡 ${e.toString()}');
      Log.y('😭 Error en SetlistSongsLocalSource método [orderSongs]');

      return ResponseModel(
        success: false,
        message: 'Ocurrió un problema al guardar el orden de las canciones'
      );
      
    }
  }
  
  @override
  Future<ResponseModel<String>> deleteSongs({
    required List<Guid> songsIds, 
    required Guid setlistId
  }) async{
     try {

      final setlistsResult = await SQLite.instance.query(
        SetlistsTable.name,
        columns: [SetlistsTable.colIsAllowToRemove],
        where: '${SetlistsTable.colId} = ?',
        whereArgs: [setlistId.toString()]
      );
      final isFavoriteSetlist = setlistsResult[0][SetlistsTable.colIsAllowToRemove] == 0;

      final batch = SQLite.instance.batch();

      for (var songId in songsIds) {
        batch.delete(
          SetlistSongsTable.name, 
          where: '${SetlistSongsTable.colSongId} = ? AND '
          '${SetlistSongsTable.colSetlistId} = ?',
          whereArgs: [
            songId.toString(),
            setlistId.toString()
          ]
        );

        if(isFavoriteSetlist){
          batch.update(
            SongsTable.name,
            {SongsTable.colIsFavorite: 0},
            where: '${SongsTable.colId} = ?', 
            whereArgs: [songId.toString()]
          );
        }
      }
      await batch.commit();
    

      return ResponseModel(
        success: true,
        message: 'Canciones removidas'
      );
      //final batch = SQLite.instance.batch();
       
     } catch (e) {

      Log.y('🤡 ${e.toString()}');
      Log.y('😭 Error en SetlistSongsLocalSource método [orderSongs]');

      return ResponseModel(
        success: false,
        message: 'Ocurrió un problema al quitar las canciones de la lista'
      );
       
     }
  }
}