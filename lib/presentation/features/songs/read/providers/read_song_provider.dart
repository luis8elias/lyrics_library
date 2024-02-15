import 'package:flutter_guid/flutter_guid.dart';
import 'package:lyrics_library/services/songs_service.dart';

import '/data/models/response_model.dart';
import '/presentation/providers/fetch_provider.dart';
import '/services/config_service.dart';

class ReadSongProvider extends FetchProvider<double>{

  final ConfigService _configService;
  final SongsService _songsService;

  ReadSongProvider({
    super.autoCall, 
    required ConfigService configService,
    required SongsService songsService
  }) : _configService = configService,
  _songsService = songsService;


  @override
  Future<ResponseModel<double>> fetchMethod() {
    return _configService.getFontSize();
  }

  void setNewFontSize(double newFontSize){
    model = newFontSize;
    notifyListeners();
  }

  Future<ResponseModel> saveFontSize() async{
    final saveFontSizeResp = await _configService.setFontSize(
      fontSize: model
    );
    if(saveFontSizeResp.isFailed){
      final getFontSizeResp = await _configService.getFontSize();
      model = getFontSizeResp.model!;
      notifyListeners();
      return saveFontSizeResp;
    }
    return saveFontSizeResp;
  }

  void incrementSongViewCont({
    required Guid songId
  }){
    _songsService.incrementSongViewsCount(songId: songId);
  }

}