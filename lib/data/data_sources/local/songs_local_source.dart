
import 'package:flutter_guid/flutter_guid.dart';

import '/config/config.dart';
import '/data/models/response_model.dart';
import '/presentation/features/genres/shared/models/genre_model.dart';
import '/presentation/features/more/scan_song/models/scanned_song_model.dart';
import '/presentation/features/songs/create/models/create_song_model.dart';
import '/presentation/features/songs/edit/models/edit_song_model.dart';
import '/presentation/features/songs/list/models/songs_filter_model.dart';
import '/presentation/features/songs/list/models/songs_list_model.dart';
import '/presentation/features/songs/shared/model/song_model.dart';
import '/services/session_service.dart';
import '/utils/db/sqlite.dart';
import '/utils/extensions/string_extensions.dart';
import '/utils/utils.dart';

class SongsLocalSource {

  final SessionService sessionService;
  SongsLocalSource({required this.sessionService});

  final int limit = Config.songsPageSize;


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

  Future<ResponseModel<String>> deleteSongs({
    required List<Guid> songsIds
  }) async{
    try {

      final questionSymbols = songsIds.map((e) => '?').join(',');
      final batch = SQLite.instance.batch();

      batch.update(
        SongsTable.name,
        {SongsTable.colIsRemoved: 1},
        where: '${SongsTable.colId} IN ($questionSymbols)', 
        whereArgs: songsIds.map((e) => e.toString()).toList()
      );
      
      batch.delete(
        SetlistSongsTable.name, 
        where : '${SetlistSongsTable.colSongId} IN ($questionSymbols)',
        whereArgs: songsIds.map((e) => e.toString()).toList(),
        
      );

      await batch.commit();

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

  Future<ResponseModel<String>> saveSongFromScan({
    required ScannedSongModel scannedSongModel
  }) async{
    try {

      final authModel = await sessionService.getAuthModel();
      final fullStr = '${scannedSongModel.title} ${scannedSongModel.lyric}';

      final genreResult = await SQLite.instance.query(
        GenresTable.name,
        columns: [GenresTable.colId],
        where: '${GenresTable.colName} = ? AND '
        '${GenresTable.colIsRemoved} = ?',
        whereArgs: [scannedSongModel.genreName ?? '', 0]
      );

      final batch = SQLite.instance.batch();

      final Guid genreId;
      if(
        genreResult.isEmpty 
        && scannedSongModel.genreName != null 
        && scannedSongModel.genreName != ''
      ){
        genreId = Guid.newGuid;
        final genre = GenreModel(
          id: genreId,
          name: scannedSongModel.genreName!.capitalize(), 
          ownerId: Guid(authModel?.userId)
        );
        batch.insert(GenresTable.name, genre.toMap());
      }else{
        genreId = Guid(genreResult[0][GenresTable.colId] as String);
      }
     

      final songMap = {
        'id': Guid.newGuid.toString(),
        'title': scannedSongModel.title,
        'lyric': scannedSongModel.lyric,
        'searchKeywords' : SearchKeywords.get(fullStr),
        'ownerId': authModel?.userId,
        'genreId': genreId.toString(),
        'sync' : 0,
        'isRemoved': 0,
        'isFavorite' : 0 
      };

      batch.insert(
        SongsTable.name, songMap
      );

      await batch.commit(noResult: true);
      await Future.delayed(Config.manualLocalServicesDelay);
    
      return ResponseModel(
        success: true, 
        message: 'Canción guardada',
        model: 'Canción guardada'
      );

    } catch (e) {

      Log.y('🤡 ${e.toString()}');
      Log.y('😭 Error en SongsLocalSource método [saveSongFromScan]');

      return ResponseModel(
        success: false,
        message: 'Ocurrió un problema al guardar la canción'
      );

    }
  }
}
  