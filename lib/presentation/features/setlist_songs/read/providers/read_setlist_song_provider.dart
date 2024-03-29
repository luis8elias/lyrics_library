import 'package:flutter_guid/flutter_guid.dart';

import '/data/models/response_model.dart';
import '/presentation/features/setlist_songs/list/model/setlist_song_model.dart';
import '/presentation/providers/fetch_provider.dart';
import '/services/config_service.dart';
import '/services/setlist_songs_service.dart';
import '/services/songs_service.dart';

class ReadSetlistSongProvider extends FetchProvider<String>{

  final SetlistSongsService _setlistSongsService;
  final SongsService _songsService;
  final ConfigService _configService;

   ReadSetlistSongProvider({
    super.autoCall = false, 
    required SetlistSongsService setlistSongsService,
    required SongsService songsService, 
    required ConfigService configService
  }) : _setlistSongsService = setlistSongsService,
  _songsService = songsService, 
  _configService = configService;

  

  
  List<SetlistSongModel> _setlistSongs= [];
  late int selectedIndex;
 
  late double fontSize;


  @override
  Future<ResponseModel<String>> fetchMethod() async{
    final fontSizeResp = await _configService.getFontSize();
    fontSize = fontSizeResp.model!;
    return _setlistSongsService.fetchSongLyricsBySongId(
      songId: _setlistSongs[selectedIndex].songId
    );
  }

  void initializeProvider({
    required int initialIndex,
    required List<SetlistSongModel> setlistSongs
  }){
    selectedIndex = initialIndex - 1;
    _setlistSongs = setlistSongs;
  }

  void changeSong(ChangeSongOptions changeSongOption){
    if(changeSongOption == ChangeSongOptions.increase){
      if(_setlistSongs.length - 1 ==  selectedIndex){
        selectedIndex = 0;
      }else{
        selectedIndex += 1;
      }
    }

    if(changeSongOption == ChangeSongOptions.decrease){
      if(selectedIndex == 0){
        selectedIndex = _setlistSongs.length - 1;
      }else{
        selectedIndex -= 1;
      }
    }
    loadData();
  }

  void changeFontSize(double newFontSize){
    fontSize = newFontSize;
    notifyListeners();
  }

  Future<ResponseModel> saveFontSize() async{
    final saveFontSizeResp = await _configService.setFontSize(
      fontSize: fontSize
    );
    if(saveFontSizeResp.isFailed){
      final getFontSizeResp = await _configService.getFontSize();
      fontSize = getFontSizeResp.model!;
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

enum ChangeSongOptions{
  increase,
  decrease
}