import 'dart:developer';

import 'package:flutter_guid/flutter_guid.dart';

import '/data/models/response_model.dart';
import '/presentation/features/setlists/shared/models/setlist_model.dart';
import '/presentation/providers/fetch_provider.dart';
import '/services/setlist_songs_service.dart';
import '/services/setlists_service.dart';

class AddToSetlistListProvider extends FetchProvider<List<SetlistModel>?>{

  final SetlistsService _setlistsService;
  final SetlistSongsService _setlistSongsService;

  String _query = '';
  final List<Guid> selectedItems = [];
  List<Guid> prevSelectedItems = [];
  Guid songId = Guid.defaultValue;
  late bool initialIsFavorite;
  bool? isFavorite;

  AddToSetlistListProvider({
    super.autoCall = false, 
    required SetlistsService setlistsService,
    required SetlistSongsService setlistSongsService
  }) : 
  _setlistSongsService = setlistSongsService,
  _setlistsService = setlistsService;

  @override
  Future<ResponseModel<List<SetlistModel>?>> fetchMethod() {
    return _fetch();
  }

  void updateQuery(String newQuery){
    if(newQuery.isEmpty && _query.isEmpty){
      return;
    }
    _query = newQuery;
    loadData();
    log('[ AddToSetlistProvider ] Query 👉🏼 $_query');
  }

  void setSongId(Guid newSongId){
    songId = newSongId;
  }

  void setInitialIsFavorite(bool isFavorite){
    initialIsFavorite = isFavorite;
  }
  void setIsFavorite(bool value){
    isFavorite = value;
  }

  void selectItem({ required Guid id}){
    if(selectedItems.contains(id)){
      selectedItems.removeWhere((element) => element == id);
    }else{
      selectedItems.add(id);
    }
    notifyListeners();
  }

  Future<ResponseModel<List<SetlistModel>?>>  _fetch() async{
    final setlistsIdsResp = await _setlistSongsService.getSetlistsIdsBySongId(songId: songId);
    if(setlistsIdsResp!.success){
      selectedItems.clear();
      selectedItems.addAll(setlistsIdsResp.model!);
      prevSelectedItems = setlistsIdsResp.model!;
    }
    return _setlistsService.fetchSetlists(query: _query);
  }



}