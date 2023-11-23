export '/utils/db/genres_table.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '/utils/db/genres_table.dart';
import '/utils/db/songs_table.dart';

class SQLite{
  static late Database instance;
  
  static Future<void> initializeDatabase() async {
    final databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'lyrics.db');
    instance = await openDatabase(
      path, 
      version: 1,
      onCreate: (Database db, int version) async {
        await GenresTable.create(db);
        await SongsTable.create(db);
      }
    );
  }
}
