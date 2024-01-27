
import 'package:flutter_guid/flutter_guid.dart';

import '/config/config.dart';
import '/data/data_sources/interfaces/songs_data_source_interface.dart';
import '/data/models/response_model.dart';
import '/presentation/features/setlists/add_song/models/add_song_to_setlist_model.dart';
import '/presentation/features/setlists/shared/models/setlist_model.dart';
import '/presentation/features/songs/create/models/create_song_model.dart';
import '/presentation/features/songs/edit/models/edit_song_model.dart';
import '/presentation/features/songs/list/models/songs_filter_model.dart';
import '/presentation/features/songs/list/models/songs_list_model.dart';
import '/presentation/features/songs/shared/model/song_model.dart';
import '/utils/db/sqlite.dart';
import '/utils/utils.dart';

class SongsLocalSource extends SongsDataSource {
  SongsLocalSource({required super.sessionService});

  final int limit = Config.songsPageSize;

  @override
  Future<ResponseModel<SongsListModel>> fetchSongs({
    required int page,
    SongFilterModel? filters
  }) async{

    if(page == 0){
      return ResponseModel(
        success: false,
        message: 'Pagina 0'
      );
    }

    try {

      
      final q = SearchKeywords.get(filters?.query ?? '');
      final qArr = q.split(' ');
      String partOfRawQury = '';
      if(qArr.length > 1){
        for (var i = 0; i < qArr.length; i++) {
          if(i == 0){
            partOfRawQury = "(S.${SongsTable.colSearchKeywords} LIKE '%${qArr[i]}%' AND ";
          }else if(i+1 == qArr.length){
            partOfRawQury += "S.${SongsTable.colSearchKeywords} LIKE '%${qArr[i]}%' ) ";
          }else{
            partOfRawQury += "S.${SongsTable.colSearchKeywords} LIKE '%${qArr[i]}%' AND ";
          }
        }
      }else{
        partOfRawQury = "S.${SongsTable.colSearchKeywords} LIKE '%$q%' ";
      }
      
      final songsMapList = await SQLite.instance.rawQuery(
        'SELECT S.*, '
        'G.name as genreName, '
        'G.ownerId as genreOwnerId, '
        'G.sync as genreSync, '
        'G.isRemoved as genreIsRemoved '
        'FROM ${SongsTable.name} as S '
        'LEFT JOIN ${GenresTable.name} as G ON '
        'S.${SongsTable.colGenreId} = G.${GenresTable.colId} '
        'AND G.isRemoved == 0 '
        'WHERE S.${SongsTable.colIsRemoved} = 0 AND '
        '$partOfRawQury'
        'LIMIT $limit OFFSET ${limit * (page - 1)} '
      );
      await Future.delayed(Config.manualLocalServicesDelay);
      final songs = SongModel.fromMapList(songsMapList);
      final count = await SQLite.instance.rawQuery(
        'SELECT COUNT(*) as total FROM ${SongsTable.name} '
        'WHERE ${SongsTable.colIsRemoved} = 0'
      );
      return ResponseModel(
        success: true,
        model: SongsListModel(
          totalSongs: count[0]['total'] as int,
          items: songs
        )
      );
    } catch (e) {

      Log.y('🤡 ${e.toString()}');
      Log.y('😭 Error en SongsLocalSource método [fetchSongs]');

      return ResponseModel(
        success: false,
        message: 'Ocurrió un probelma al obtener las canciones'
      );

    }
  }

  @override
  Future<ResponseModel<SongModel>> createSong({
    required CreateSongModel createSongModel
  }) async{
     try {

      final authModel = await sessionService.getAuthModel();

      final song = SongModel.fromCreateSongModel(
        createSongModel: createSongModel,
        userId: authModel?.userId ?? ''
      );

      song;
      
      final result = await SQLite.instance.insert(
        SongsTable.name, song.toInsertMap()
      );

    if(result == 0){
      return ResponseModel(
        success: false,
        message: 'Ocurrió un problema al crear la canción'
      );
    }
    await Future.delayed(Config.manualLocalServicesDelay);
    
    return ResponseModel(
      success: true, 
      message: 'Canción creado',
      model: song
    );

    } catch (e) {

      Log.y('🤡 ${e.toString()}');
      Log.y('😭 Error en SongsLocalSource método [createSong]');

      return ResponseModel(
        success: false,
        message: 'Ocurrió un problema al crear la canción'
      );

    }
  }

  @override
  Future<ResponseModel<String>> deleteSongs({
    required List<Guid> songsIds
  }) async{
    try {

      final questionSymbols = songsIds.map((e) => '?').join(',');
      final rowsAffected = await  SQLite.instance.rawUpdate(
        'UPDATE ${SongsTable.name} SET isRemoved = ? '
        'WHERE ${SongsTable.colId} IN ($questionSymbols)',
        [1, ...songsIds.map((e) => e.toString()).toList()]
      );
      
      if(rowsAffected == 0){
        return ResponseModel(
          success: false,
          message: 'Ocurrió un problema al eliminar'
        );
      }
      await Future.delayed(Config.manualLocalServicesDelay);
      
      return ResponseModel(
        success: true, 
        message: songsIds.length > 1 ? 'Canciones eliminados' : 'Canción eliminada' ,
        model: ''
      );

    } catch (e) {

      Log.y('🤡 ${e.toString()}');
      Log.y('😭 Error en SongsLocalSource método [deleteSongs]');

      return ResponseModel(
        success: false,
        message: 'Ocurrió un problema al eliminar la canción'
      );

    }
  }

  @override
  Future<ResponseModel<SongModel?>> editSong({
    required EditSongModel editSongModel
  }) async{
     try {

      final editedSong = editSongModel.toMapWithoutId();
      final rowsAffected = await SQLite.instance.update(
        SongsTable.name, 
        editedSong,
        where: '${SongsTable.colId} = ?',
        whereArgs: [editSongModel.id.toString()]
      );
      
      if(rowsAffected == 0){
        return ResponseModel(
          success: false,
          message: 'Ocurrió un problema al editar la canción'
        );
      }
      await Future.delayed(Config.manualLocalServicesDelay);


      final songsList = await SQLite.instance.rawQuery(
        'SELECT S.*, '
        'G.name as genreName, '
        'G.ownerId as genreOwnerId, '
        'G.sync as genreSync, '
        'G.isRemoved as genreIsRemoved '
        'FROM ${SongsTable.name} as S LEFT JOIN ${GenresTable.name} as G ON '
        'S.${SongsTable.colGenreId} = G.${GenresTable.colId} '
        'WHERE S.${SongsTable.colId} = ? ',
        [editSongModel.id.toString()]
      );

      final song = SongModel.fromMap(songsList[0]);
      
      return ResponseModel(
        success: true, 
        message: 'Canción editada' ,
        model: song
      );

    } catch (e) {

      Log.y('🤡 ${e.toString()}');
      Log.y('😭 Error en SongsLocalSource método [editSong]');

      return ResponseModel(
        success: false,
        message: 'Ocurrió un problema al editar la canción'
      );

    }
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