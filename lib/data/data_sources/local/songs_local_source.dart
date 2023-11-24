import 'package:lyrics_library/presentation/features/songs/list/models/songs_list_model.dart';

import '/config/config.dart';
import '/data/data_sources/interfaces/songs_data_source_interface.dart';
import '/data/models/response_model.dart';
import '/presentation/features/songs/shared/model/song_model.dart';
import '/utils/db/songs_table.dart';
import '/utils/db/sqlite.dart';
import '/utils/logger/logger_helper.dart';

class SongsLocalSource extends SongsDataSource {
  SongsLocalSource({required super.sessionService});

  final int limit = Config.songsPageSize;

  @override
  Future<ResponseModel<SongsListModel>> fetchSongs({
    required int page
  }) async{

    if(page == 0){
      return ResponseModel(
        success: false,
        message: 'Pagina 0'
      );
    }

    try {
      
      final songsMapList = await SQLite.instance.rawQuery(
        'SELECT S.*, '
        'G.name as genreName, '
        'G.ownerId as genreOwnerId, '
        'G.sync as genreSync, '
        'G.isRemoved as genreIsRemoved '
        'FROM ${SongsTable.name} as S LEFT JOIN ${GenresTable.name} as G ON '
        'S.${SongsTable.colGenreId} = G.${GenresTable.colId} '
        'WHERE S.${SongsTable.colIsRemoved} = 0 '
        'LIMIT $limit OFFSET ${limit * (page -1)} '
        
      );
      await Future.delayed(const Duration(milliseconds: 500));
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
}