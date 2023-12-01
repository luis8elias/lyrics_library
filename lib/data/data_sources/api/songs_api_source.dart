import 'package:flutter_guid/flutter_guid.dart';
import '/presentation/features/songs/edit/models/edit_song_model.dart';

import '/data/data_sources/interfaces/songs_data_source_interface.dart';
import '/presentation/features/songs/create/models/create_song_model.dart';
import '/presentation/features/songs/list/models/songs_list_model.dart';
import '/presentation/features/genres/shared/models/genre_model.dart';
import '/presentation/features/songs/shared/model/song_model.dart';
import '/data/models/response_model.dart';

class SongsApiSource extends SongsDataSource{
  SongsApiSource({required super.sessionService});

   SongModel _createMockModel(String name, String ownerId){
    return SongModel(
      id: Guid.newGuid, 
      title: name, 
      lyric: 'demo', 
      ownerId: Guid(ownerId), 
      genreModel: GenreModel(
        id: Guid.newGuid, 
        name: 'MockGenre', 
        ownerId: Guid(ownerId)
      )
    );
  }

  
  @override
  Future<ResponseModel<SongsListModel>> fetchSongs({
    required int page,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    final authModel = await sessionService.getAuthModel();

    if(page == 3){

      final songs = List.generate(5, (index) {
        final oldItemsCount = (page - 1 ) * 25 + 1;
        final id = oldItemsCount + index;
        return _createMockModel('Song $id', authModel!.userId);
      });

      return ResponseModel(
        success: true,
        message: 'ok',
        model: SongsListModel(
          totalSongs: 55,
           items: songs
        ),
      );

    }

     final songs = List.generate(25, (index) {
      if(page > 1){
        final oldItemsCount = (page - 1 ) * 25 + 1;
        final id = oldItemsCount + index;
        return _createMockModel('Song $id', authModel!.userId);
      }
      return _createMockModel('Song ${index+1}', authModel!.userId);
    });
    
    return ResponseModel(
      success: true,
      message: 'ok',
      model: SongsListModel(
        totalSongs: 55,
         items: songs
      ),
    );   
  }

  @override
  Future<ResponseModel<SongModel>> createSong({
    required CreateSongModel createSongModel
  }) {
    throw UnimplementedError();
  }
  
  @override
  Future<ResponseModel<String>> deleteSongs({
    required List<Guid> songsIds
  }) {
    // TODO: implement deleteSongs
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<SongModel?>> editSong({
    required EditSongModel editSongModel
  }) {
    // TODO: implement editSong
    throw UnimplementedError();
  }
}