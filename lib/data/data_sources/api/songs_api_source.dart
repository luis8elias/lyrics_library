import '/data/models/response_model.dart';

import '../interfaces/songs_data_source_interface.dart';

class SongsApiSource extends SongsDataSource{
  
  @override
  Future<ResponseModel<List<String>?>> fetchSongs({
    required int page,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    if(page == 3){

      return ResponseModel(
        success: true,
        message: 'ok',
        model: List.generate(5, (index) {
          final oldItemsCount = (page - 1 ) * 25 + 1;
          final id = oldItemsCount + index;
          return 'Song $id';
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
          return 'Song $id';
        }
        return 'Song ${index+1}';
      })
    );   
  }
}