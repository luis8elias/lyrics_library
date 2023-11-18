import 'package:flutter_guid/flutter_guid.dart';
import 'package:sqflite/sqflite.dart';

class GenresTable{
  static const name = 'genres';
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnOwnerId = 'ownerId';

  static Future<void> create(Database db) async {
    await db.execute(
      'CREATE TABLE ${GenresTable.name}(${GenresTable.columnId} TEXT PRIMARY KEY, ${GenresTable.columnName} TEXT, ownerId TEXT)'
    );
    _seed(db);
  }

  static Future<void> _seed(Database db) async {
    List<Map> maps = await db.query(
      GenresTable.name,
      columns: [GenresTable.columnId],
      where: '${GenresTable.columnId} = ?',
      whereArgs: ['1234']
    );
    if(maps.isEmpty ){
      await db.insert(GenresTable.name, {
        'id': Guid.newGuid.toString(),
        'name': 'demo',
        'ownerId': Guid.newGuid.toString()
      });
    }
  }
}