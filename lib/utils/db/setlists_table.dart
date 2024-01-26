import 'package:flutter_guid/flutter_guid.dart';
import 'package:sqflite/sqflite.dart';

import '/utils/logger/logger_helper.dart';

class SetlistsTable{
  static const name = 'setlists';
  static const colId = 'id';
  static const colName = 'name';
  static const colOwnerId = 'ownerId';
  static const colSync = 'sync';
  static const colIsAllowToRemove = 'allowToRemove';
  static const colIsRemoved = 'isRemoved';

  static Future<void> create(Database db) async {
    await db.execute(
      'CREATE TABLE ${SetlistsTable.name} ('
        '${SetlistsTable.colId} TEXT PRIMARY KEY, '
        '${SetlistsTable.colName} TEXT, '
        '${SetlistsTable.colOwnerId} TEXT, '
        '${SetlistsTable.colSync} INTEGER, '
        '${SetlistsTable.colIsAllowToRemove} INTEGER, '
        '${SetlistsTable.colIsRemoved} INTEGER '
      ')'
    );
  }

  static Future<void> seed(Database db, String ownerId) async {
    List<Map> maps = await db.query(
      SetlistsTable.name,
      columns: [SetlistsTable.colId],
    );
    if(maps.isEmpty ){
      final rowsAffected = await db.insert(SetlistsTable.name, {
        'id': Guid.newGuid.toString(),
        'name': 'Special setlist',
        'ownerId': ownerId,
        'sync' : 0,
        'allowToRemove' : 0,
        'isRemoved' : 0
      });
      if(rowsAffected > 0){
        Log.g('🫡 Setlist seed success');
      }else{
        Log.r('🫡 Setlist seed failed');
      }
    }
  }
}