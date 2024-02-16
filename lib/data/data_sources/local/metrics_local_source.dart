import '/data/models/response_model.dart';
import '/presentation/features/more/metrics/models/general_count_model.dart';
import '/presentation/features/more/metrics/models/genre_song_count_model.dart';
import '/presentation/features/more/metrics/models/most_read_song_model.dart';
import '/utils/db/sqlite.dart';
import '/utils/logger/logger_helper.dart';

class MetricsLocalSource{


  Future<ResponseModel<GeneralCountModel?>> getGeneralCount() async {

    try {

      final songsCount = await _getTableCount(SongsTable.name);
      final genresCount = await _getTableCount(GenresTable.name);
      final setlistsCount = await _getTableCount(SetlistsTable.name);

      return ResponseModel(
        success: true,
        message: 'General count',
        model: GeneralCountModel(
          totalSongs: songsCount,
          totalGenres: genresCount,
          totalSetlists: setlistsCount
        )
      );


    } catch (e) {

      Log.y('🤡 ${e.toString()}');
      Log.y('😭 Error en MetricsLocalSource método [getGeneralCount]');

      return ResponseModel(
        success: false,
        message: 'Ocurrió un problema al consultar el conteo general',
      );
      
    }

  }


  Future<ResponseModel<List<MostReadSongModel>?>> topMostReadSongs() async {

    try {

      final resp = await SQLite.instance.rawQuery(
        'SELECT S.${SongsTable.colViewsCount} as views, '
        'S.${SongsTable.colTitle} as song, '
        'G.${GenresTable.colName} as genre '
        'FROM ${SongsTable.name} as S LEFT JOIN '
        '${GenresTable.name} as G ON '
        'S.${SongsTable.colGenreId} = G.${GenresTable.colId} '
        'AND G.${GenresTable.colIsRemoved} = 0 '
        'WHERE S.${SongsTable.colIsRemoved} = 0 '
        'ORDER BY S.${SongsTable.colViewsCount} DESC, '
        'S.${SongsTable.colTitle} ASC '
        'LIMIT 5'
      );

      final list = resp.map(( map ) => 
        MostReadSongModel.fromMap(map)
      ).toList();

      return ResponseModel(
        success: true,
        message: 'top Most Read Songs',
        model: list
      );


    } catch (e) {

      Log.y('🤡 ${e.toString()}');
      Log.y('😭 Error en MetricsLocalSource método [topMostReadSongs]');

      return ResponseModel(
        success: false,
        message: 'Ocurrió un problema al consultar las canciones mas leidas',
      );
      
    }

  }

  Future<ResponseModel<GenresSongCountResp?>> songCountByGenre() async {

    try {

      final resp = await SQLite.instance.rawQuery(
        'SELECT COUNT(S.${SongsTable.colGenreId}) as count, '
        'G.${GenresTable.colName} as genre '
        'FROM ${SongsTable.name} as S LEFT JOIN '
        '${GenresTable.name} as G ON '
        'S.${SongsTable.colGenreId} = G.${GenresTable.colId} '
        'GROUP BY S.${SongsTable.colGenreId} '
        'HAVING S.${SongsTable.colIsRemoved} = 0 AND '
        'G.${GenresTable.colIsRemoved} = 0 '
        'ORDER BY count DESC '
        'LIMIT 3'
      );

      final list = resp.map(( map ) => 
        GenreSongCountModel.fromMap(map)
      ).toList();

      return ResponseModel(
        success: true,
        message: 'songs count by genre',
        model: GenresSongCountResp(
          data: list
        )
      );


    } catch (e) {

      Log.y('🤡 ${e.toString()}');
      Log.y('😭 Error en MetricsLocalSource método [songCountByGenre]');

      return ResponseModel(
        success: false,
        message: 'songs count by genre',
      );
      
    }

  }



  Future<int> _getTableCount(String tableName) async {

    final resp = await SQLite.instance.rawQuery(
      'SELECT COUNT(*) as count FROM $tableName where isRemoved = 0'
    );

    return resp[0]['count'] as int;

  }
}