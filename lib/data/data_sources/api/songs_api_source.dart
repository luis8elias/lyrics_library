import 'package:flutter_guid/flutter_guid.dart';

import '/presentation/features/genres/shared/models/genre_model.dart';
import '/presentation/features/songs/shared/model/song_model.dart';
import '/data/models/response_model.dart';
import '../interfaces/songs_data_source_interface.dart';

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
  Future<ResponseModel<List<SongModel>?>> fetchSongs({
    required int page,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    final authModel = await sessionService.getAuthModel();

    if(page == 3){

      return ResponseModel(
        success: true,
        message: 'ok',
        model: List.generate(5, (index) {
          final oldItemsCount = (page - 1 ) * 25 + 1;
          final id = oldItemsCount + index;
          return _createMockModel('Song $id', authModel!.userId);
        })
      );

    }
    
    return ResponseModel(
      success: true,
      message: 'ok',
      model: List.generate(25, (index) {
        if(page > 1){
          final oldItemsCount = (page - 1 ) * 25 + 1;
          final id = oldItemsCount + index;
          return _createMockModel('Song $id', authModel!.userId);
        }
        return _createMockModel('Song ${index+1}', authModel!.userId);
      })
    );   
  }
}