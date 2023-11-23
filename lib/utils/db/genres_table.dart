import 'package:flutter_guid/flutter_guid.dart';
import 'package:sqflite/sqflite.dart';

class GenresTable{
  static const name = 'genres';
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnOwnerId = 'ownerId';
  static const columnSync = 'sync';
  static const columnIsRemoved = 'isRemoved';

  static Future<void> create(Database db) async {
    await db.execute(
      'CREATE TABLE ${GenresTable.name}(${GenresTable.columnId} TEXT PRIMARY KEY, ${GenresTable.columnName} TEXT, ${GenresTable.columnOwnerId} TEXT, ${GenresTable.columnSync} INTEGER, ${GenresTable.columnIsRemoved} INTEGER)'
    );
    _seed(db);
  }

  static Future<void> _seed(Database db) async {
    List<Map> maps = await db.query(
      GenresTable.name,
      columns: [GenresTable.columnId],
    );
    if(maps.isEmpty ){
      await db.insert(GenresTable.name, {
        'id': Guid.newGuid.toString(),
        'name': 'Demo',
        'ownerId': Guid.newGuid.toString(),
        'sync' : 0,
        'isRemoved' : 0
      });
    }
  }
}