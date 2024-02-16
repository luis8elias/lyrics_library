import '/data/data_sources/local/metrics_local_source.dart';
import '/data/models/response_model.dart';
import '/presentation/features/more/metrics/models/general_count_model.dart';
import '/presentation/features/more/metrics/models/genre_song_count_model.dart';
import '/presentation/features/more/metrics/models/most_read_song_model.dart';

class MetricsService {

  final MetricsLocalSource _localSource;

  MetricsService({
    required MetricsLocalSource localSource
  }) : _localSource = localSource;


  Future<ResponseModel<GeneralCountModel?>> getGeneralCount() async{
    return _localSource.getGeneralCount();
  }

  Future<ResponseModel<List<MostReadSongModel>?>> topMostReadSongs() {
    return _localSource.topMostReadSongs();
  }

  Future<ResponseModel<GenresSongCountResp?>> songCountByGenre(){
    return _localSource.songCountByGenre(); 
  }

}