import 'package:flutter_guid/flutter_guid.dart';

import '/data/data_sources/interfaces/setlist_songs_data_source_interface.dart';
import '/presentation/features/setlists/read/model/setlist_song_model.dart';
import '/presentation/features/songs/shared/model/song_model.dart';

//import '/config/config.dart';
//import '/data/data_sources/interfaces/setlists_data_source_interface.dart';
import '/data/models/response_model.dart';
//import '/presentation/features/setlists/create/models/create_setlist_model.dart';
//import '/presentation/features/setlists/edit/models/edit_setlist_model.dart';
//import '/presentation/features/setlists/shared/models/setlist_model.dart';
//import '/utils/db/setlists_table.dart';
//import '/utils/db/sqlite.dart';
//import '/utils/extensions/string_extensions.dart';
//import '/utils/logger/logger_helper.dart';

class SetlistSongsLocalSource extends SetlistSongsDataSource {
  SetlistSongsLocalSource({required super.sessionService});

  @override
  Future<ResponseModel<List<SetlistSongModel>?>> fetchsSongsBySetlistId({
    required Guid setlistId, 
    required String query
  }) {
    // TODO: implement fetchsSongsBySetlistId
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<SongModel?>> addSongsToSetlist() {
    // TODO: implement addSongsToSetlist
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<String>> deleteSongsFromSetlist({
    required List<Guid> songsIds
  }) {
    // TODO: implement deleteSongsFromSetlist
    throw UnimplementedError();
  }
 

}