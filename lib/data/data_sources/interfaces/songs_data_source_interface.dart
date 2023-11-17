import '/data/models/response_model.dart';

abstract class SongsDataSource{

  Future<ResponseModel<List<String>?>> fetchSongs({
    required int page,
    //required SongsFilterModel filterModel
  });

  

}