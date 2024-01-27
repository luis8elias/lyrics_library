import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '/utils/db/genres_table.dart';
import '/utils/db/setlist_songs_table.dart';
import '/utils/db/setlists_table.dart';
import '/utils/db/songs_table.dart';

export '/utils/db/genres_table.dart';
export '/utils/db/setlist_songs_table.dart';
export '/utils/db/setlists_table.dart';
export '/utils/db/songs_table.dart';

class SQLite{
  static late Database instance;
  
  
  static Future<void> initializeDatabase() async {
    final databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'lyrics.db');
    instance = await openDatabase(
      path, 
      version: 2,
      onCreate: (Database db, int version) async {
        await GenresTable.create(db);
        await SongsTable.create(db);
        await SetlistsTable.create(db);
        await SetlistSongsTable.create(db);
      }
    );
  }


  static Future<void> seedTables(String ownerId) async {
    await GenresTable.seed(instance, ownerId);
    await SetlistsTable.seed(instance, ownerId);
  }
}
