import 'package:flutter_guid/flutter_guid.dart';
import 'package:sqflite/sqflite.dart';

import '/utils/logger/logger_helper.dart';
import '/presentation/features/genres/shared/models/genre_model.dart';
import '/utils/db/genres_table.dart';

class SongsTable{
  static const name = 'songs';
  static const colId = 'id';
  static const colTitle = 'title';
  static const colLyric = 'lyric';
  static const colSearchKeywords = 'searchKeywords';
  static const colOwnerId = 'ownerId';
  static const colGenreId = 'genreId';
  static const colSync = 'sync';
  static const colIsRemoved = 'isRemoved';
  static const colIsFavorite = 'isFavorite';



  static Future<void> create(Database db) async {
    await db.execute(
      'CREATE TABLE ${SongsTable.name} ('
        '${SongsTable.colId} TEXT PRIMARY KEY, '
        '${SongsTable.colTitle} TEXT, '
        '${SongsTable.colLyric} TEXT, '
        '${SongsTable.colSearchKeywords} TEXT, '
        '${SongsTable.colOwnerId} TEXT, '
        '${SongsTable.colGenreId} TEXT, '
        '${SongsTable.colSync} INTEGER, '
        '${SongsTable.colIsRemoved} INTEGER, '
        '${SongsTable.colIsFavorite} INTEGER'
      ')'
    );
  }

  static Future<void> seed(Database db) async {
    List<Map<String,dynamic>> songsMaps = await db.query(
      SongsTable.name,
      columns: [SongsTable.colId],
    );
    if(songsMaps.isEmpty ){

      List<Map<String,dynamic>> genreMaps = await db.query(
        GenresTable.name,
      );

      if(genreMaps.isNotEmpty){

        try {
          int totalRowsInserted = 0;

          for (var i = 1; i <= 100; i++) {

            final rowsInserted = await db.insert(SongsTable.name, {
              SongsTable.colId : Guid.newGuid.toString(),
              SongsTable.colTitle : 'Seeded Song $i',
              SongsTable.colLyric : 'Lorem ipsum dolor',
              SongsTable.colSearchKeywords : 'Seeded Song $i Lorem ipsum dolor',
              SongsTable.colOwnerId : Guid.newGuid.toString(),
              SongsTable.colGenreId : GenreModel.fromMap(genreMaps[0]).idAsStr,
              SongsTable.colSync : 0,
              SongsTable.colIsRemoved : 0
            });
            totalRowsInserted = rowsInserted;
          }

          Log.g('🫡 $totalRowsInserted songs seed success');

        } catch (e) {
          Log.r('🫡 Song seed failed');
        }

      }else{
        Log.r('😥 Song seed failed');
      }

     
    }
  }
}