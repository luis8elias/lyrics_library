import '/presentation/features/songs/shared/model/song_model.dart';
import '/services/session_service.dart';
import '/data/models/response_model.dart';

abstract class SongsDataSource{

  final SessionService sessionService;

  SongsDataSource({required this.sessionService});

  Future<ResponseModel<List<SongModel>?>> fetchSongs({
    required int page,
    //required SongsFilterModel filterModel
  });

  

}