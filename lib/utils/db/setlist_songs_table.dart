import 'package:sqflite/sqflite.dart';

class SetlistSongsTable{
  static const name = 'setlist_songs';
  static const colId = 'id';
  static const colSetlistId = 'setlistId';
  static const colSongId = 'songId';
  static const colIndexOrder = 'indexOrder';
  static const colOwnerId = 'ownerId';
  static const colSync = 'sync';
  

  static Future<void> create(Database db) async {
    await db.execute(
      'CREATE TABLE ${SetlistSongsTable.name} ('
        '${SetlistSongsTable.colId} TEXT PRIMARY KEY, '
        '${SetlistSongsTable.colSetlistId} TEXT, '
        '${SetlistSongsTable.colSongId} TEXT, '
        '${SetlistSongsTable.colIndexOrder} INTEGER, '
        '${SetlistSongsTable.colOwnerId} TEXT, '
        '${SetlistSongsTable.colSync} INTEGER '
      ')'
    );
  }

}