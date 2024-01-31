import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '/presentation/features/setlist_songs/add/models/song_model_from_add_song_to_setlist_model.dart';
import '/services/setlist_songs_service.dart';
import '/config/config.dart';
import '/presentation/features/songs/list/models/songs_filter_model.dart';

class AddSongToSetlistListProvider extends ChangeNotifier{

  final SetlistSongsService _setlistSongsService;
  AddSongToSetlistListProvider({

    required SetlistSongsService setlistSongsService
  }) : _setlistSongsService = setlistSongsService;

  final PagingController<int, SongModelFromAddSongToSetlistModel> 
  _pagingController = PagingController(firstPageKey: 1);
  final _pageSize = Config.songsPageSize;
  int totalSongs = 0;
  SongFilterModel _filters = SongFilterModel();
  Guid _setlistId = Guid.newGuid;
  Guid get getSetlistId => _setlistId;
  PagingController<int, SongModelFromAddSongToSetlistModel> 
  get songsController => _pagingController;

 
  

  void addListenerToPagingController(){
    _pagingController.addPageRequestListener((page) {
      fetchSongsToAddToSetlist(page: page);
    });
  }

  void disposePagingController(){
    _pagingController.addPageRequestListener((page) {
      fetchSongsToAddToSetlist(page: page);
    });
  }


  Future<void> fetchSongsToAddToSetlist({required int page}) async {
    final response = await _setlistSongsService.fetchSongsToAddToSetlist(
      page: page,
      query: _filters.query,
      setlistId: _setlistId
    );
    if(response.isFailed){
      _pagingController.error = response.message;
      return;
    }
    final isLastPage = response.model!.items.length < _pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(response.model!.items);
    } else {
      final nextPage = page + 1;
      _pagingController.appendPage(response.model!.items, nextPage);
    }
    totalSongs = response.model!.totalSongs;
    notifyListeners();
  }


  void refresh() {
    _pagingController.refresh();
    notifyListeners();
  }
  

  void removeSong(Guid songId){
    totalSongs -= 1;
    _pagingController.itemList!.removeWhere((song) => song.songId == songId);
    notifyListeners();
  }
  
  void updateFilters(SongFilterModel Function(SongFilterModel filters) update){
    final temp = update(_filters);
    if(temp.query.isEmpty && _filters.query.isEmpty){
      return;
    }
    _filters = update(_filters);
    songsController.refresh();
    log('[ AddSongToSetlistListProvider ] Model 👉🏼 ${_filters.toMap().toString()}');
  }

  Future<void> setSetlistId({required Guid setlistId}) async{
    _setlistId = setlistId;
  }
  
}