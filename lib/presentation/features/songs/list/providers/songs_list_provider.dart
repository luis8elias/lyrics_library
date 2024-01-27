import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '/config/config.dart';
import '/presentation/features/songs/list/models/songs_filter_model.dart';
import '/presentation/features/songs/shared/model/song_model.dart';
import '/presentation/providers/providers.dart';
import '/services/songs_service.dart';

class SongsListProvider extends ChangeNotifier with SelectableListProvider<Guid>{

  final SongsService _songsService;
  SongsListProvider({required SongsService songsService}) : _songsService = songsService;

  final PagingController<int, SongModel> _pagingController = PagingController(firstPageKey: 1);
  final _pageSize = Config.songsPageSize;
  int totalSongs = 0;
  SongFilterModel _filters = SongFilterModel();

  PagingController<int, SongModel> get songsController => _pagingController;

  SongModel get getFirstSongSelected => _pagingController.itemList!.firstWhere(
    (element) => element.id == selectedItems[0]
  );
  

  void addListenerToPagingController(){
    _pagingController.addPageRequestListener((page) {
      fetchSongs(page: page);
    });
  }

  void disposePagingController(){
    _pagingController.addPageRequestListener((page) {
      fetchSongs(page: page);
    });
  }


  Future<void> fetchSongs({required int page}) async {
    final response = await _songsService.fetchSongs(
      page: page,
      filters: _filters
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
    if(isSelectItemOpened){
      openCloseSelectItem();
    }
    _pagingController.refresh();
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

  void deleteSongs(){
    totalSongs -= 1;
    _pagingController.itemList!.removeWhere((song) => selectedItems.contains(song.id));
    openCloseSelectItem();
    notifyListeners();
  }

  void editSong(SongModel songModel){
    final index = _pagingController.itemList!.indexWhere(
      (song) => song.id == songModel.id
    );
    _pagingController.itemList![index] = songModel;
    if(isSelectItemOpened){
      openCloseSelectItem();
    }
    notifyListeners();
  }

  void updateFilters(SongFilterModel Function(SongFilterModel filters) update){
    final temp = update(_filters);
    if(temp.query.isEmpty && _filters.query.isEmpty){
      return;
    }
    _filters = update(_filters);
    songsController.refresh();
    log('[ SongsListProvider ] Model 👉🏼 ${_filters.toMap().toString()}');
  }

  void toggleFavoriteSong({
    required SongModel songModel
  }){
    final index = _pagingController.itemList!.indexWhere(
      (song) => song.id == songModel.id
    );
    _pagingController.itemList![index] = songModel;
    if(isSelectItemOpened){
      openCloseSelectItem();
    }
    notifyListeners();
  }
  

  
}