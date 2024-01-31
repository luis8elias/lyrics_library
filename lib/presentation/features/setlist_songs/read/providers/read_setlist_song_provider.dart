import 'package:lyrics_library/data/models/response_model.dart';
import 'package:lyrics_library/presentation/features/setlist_songs/list/model/setlist_song_model.dart';
import 'package:lyrics_library/presentation/providers/fetch_provider.dart';
import 'package:lyrics_library/services/setlist_songs_service.dart';

class ReadSetlistSongProvider extends FetchProvider<String>{

  final SetlistSongsService _setlistSongsService;

  ReadSetlistSongProvider({
    super.autoCall = false, 
    required SetlistSongsService setlistSongsService
  }) : _setlistSongsService = setlistSongsService;

  
  List<SetlistSongModel> _setlistSongs= [];
  late int selectedIndex;


  @override
  Future<ResponseModel<String>> fetchMethod() {
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



}

enum ChangeSongOptions{
  increase,
  decrease
}