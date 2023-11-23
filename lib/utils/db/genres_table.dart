import 'package:flutter_guid/flutter_guid.dart';
import 'package:sqflite/sqflite.dart';

import '/utils/logger/logger_helper.dart';

class GenresTable{
  static const name = 'genres';
  static const colId = 'id';
  static const colName = 'name';
  static const colOwnerId = 'ownerId';
  static const colSync = 'sync';
  static const colIsRemoved = 'isRemoved';

  static Future<void> create(Database db) async {
    await db.execute(
      'CREATE TABLE ${GenresTable.name} ('
        '${GenresTable.colId} TEXT PRIMARY KEY, '
        '${GenresTable.colName} TEXT, '
        '${GenresTable.colOwnerId} TEXT, '
        '${GenresTable.colSync} INTEGER, '
        '${GenresTable.colIsRemoved} INTEGER '
      ')'
    );
    _seed(db);
  }

  static Future<void> _seed(Database db) async {
    List<Map> maps = await db.query(
      GenresTable.name,
      columns: [GenresTable.colId],
    );
    if(maps.isEmpty ){
      final rowsAffected = await db.insert(GenresTable.name, {
        'id': Guid.newGuid.toString(),
        'name': 'Demo',
        'ownerId': Guid.newGuid.toString(),
        'sync' : 0,
        'isRemoved' : 0
      });
      if(rowsAffected > 0){
        Log.g('🫡 Genre seed success');
      }else{
        Log.r('🫡 Genre seed failed');
      }
    }
  }
}