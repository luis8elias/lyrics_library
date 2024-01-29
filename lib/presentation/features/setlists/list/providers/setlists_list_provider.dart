import 'dart:developer';

import 'package:flutter_guid/flutter_guid.dart';

import '/data/models/response_model.dart';
import '/presentation/features/setlists/shared/models/setlist_model.dart';
import '/presentation/providers/providers.dart';
import '/services/setlists_service.dart';

class SetlistsListProvider extends FetchProvider<List<SetlistModel>?> with SelectableListProvider<Guid>{
  final SetlistsService _setlistsService;

  SetlistsListProvider({
    required SetlistsService setlistsService
  }) : _setlistsService = setlistsService;

  
  SetlistModel get getFirstSetlistSelected => model!.firstWhere(
    (element) => element.id == selectedItems[0]
  );
  String _query = '';



  @override
  Future<ResponseModel<List<SetlistModel>?>> fetchMethod() {
    return _setlistsService.fetchSetlists(
      query: _query
    );
  }

  Future<void> refreshSetlists() async{
    loadData();
  }

  Future<void> addSetlist({required 
    SetlistModel setlistModel
  }) async{
    model!.add(setlistModel);
    notifyListeners();
  }
  

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



  void deleteSetlists(){
    model!.removeWhere((genre) => selectedItems.contains(genre.id));
    openCloseSelectItem();
    notifyListeners();
  }

  void editSetlist(SetlistModel setlistModel){
    final index = model!.indexWhere((setlist) => setlist.id == setlistModel.id);
    model![index] = setlistModel;
    if(isSelectItemOpened){
      openCloseSelectItem();
    }
    notifyListeners();
  }

  void updateQuery(String newQuery){
    if(newQuery.isEmpty && _query.isEmpty){
      return;
    }
    _query = newQuery;
    refreshSetlists();
    log('[ SetlistsListProvider ] Query 👉🏼 $_query');
  }

  void decrementSetlistTotalSongsCount(Guid setlistId, int count){
    final index = model!.indexWhere((setlist) => setlist.id == setlistId);
    final setlistCoopy = model![index].copyWith(
      totalSongs: model![index].totalSongs - count,
      
    );
    model![index] = setlistCoopy;
    if(isSelectItemOpened){
      openCloseSelectItem();
    }
    notifyListeners();
  }

  

}