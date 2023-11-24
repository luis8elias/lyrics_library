import '/presentation/features/songs/list/models/songs_list_model.dart';
import '/services/session_service.dart';
import '/data/models/response_model.dart';

abstract class SongsDataSource{

  final SessionService sessionService;

  SongsDataSource({required this.sessionService});

  Future<ResponseModel<SongsListModel>> fetchSongs({
    required int page,
    //required SongsFilterModel filterModel
  });

  

}