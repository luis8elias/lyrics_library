import 'dart:developer';

import 'package:flutter_guid/flutter_guid.dart';

import '/presentation/features/setlists/read/model/setlist_song_model.dart';
import '/services/setlist_songs_service.dart';
import '/data/models/response_model.dart';
import '/presentation/providers/providers.dart';


class ReadSetlistsProvider extends FetchProvider<List<SetlistSongModel>?> with SelectableListProvider<Guid>{
  final SetlistSongsService _setlistSongsService;

  ReadSetlistsProvider({
    required SetlistSongsService setlistSongsService
  }) : _setlistSongsService = setlistSongsService, super(autoCall: false);

  
  SetlistSongModel get getFirstSetlistSelected => model!.firstWhere(
    (element) => element.id == selectedItems[0]
  );
  String _query = '';
  Guid _setlistId = Guid.defaultValue;



  @override
  Future<ResponseModel<List<SetlistSongModel>?>> fetchMethod() {
    return _setlistSongsService.fetchsSongsBySetlistId(
      setlistId: _setlistId,
      query: _query
    );
  }

  Future<void> refreshSetlistSongs() async{
    loadData();
  }

  Future<void> setSetlistId({required Guid setlistId}) async{
    _setlistId = setlistId;
  }

  // Future<void> addSetlist({required 
  //   SetlistModel setlistModel
  // }) async{
  //   model!.add(setlistModel);
  //   notifyListeners();
  // }
  

  @override
  void openCloseSelectItem({Guid? id}) {
    super.openCloseSelectItem(
      id: id
    );
    notifyListeners();
  }

  @override
  void selectItem({required Guid id}) {
    super.selectItem(
      id: id
    );
    notifyListeners();
  }



  // void deleteSetlists(){
  //   model!.removeWhere((genre) => selectedItems.contains(genre.id));
  //   openCloseSelectItem();
  //   notifyListeners();
  // }

  // void editSetlist(SetlistModel setlistModel){
  //   final index = model!.indexWhere((setlist) => setlist.id == setlistModel.id);
  //   model![index] = setlistModel;
  //   if(isSelectItemOpened){
  //     openCloseSelectItem();
  //   }
  //   notifyListeners();
  // }

  void updateQuery(String newQuery){
    if(newQuery.isEmpty && _query.isEmpty){
      return;
    }
    _query = newQuery;
    refreshSetlistSongs();
    log('[ SetlistsListProvider ] Query 👉🏼 $_query');
  }

  void reorderSongs(int oldIndex, int newIndex){
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final SetlistSongModel item = model!.removeAt(oldIndex);
    model!.insert(newIndex, item);
    notifyListeners();
  }

  

}