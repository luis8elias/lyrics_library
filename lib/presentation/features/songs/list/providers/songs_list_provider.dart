import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '/config/config.dart';
import '/presentation/features/songs/shared/model/song_model.dart';
import '/services/songs_service.dart';

class SongsListProvider extends ChangeNotifier{

  final SongsService _songsService;
  SongsListProvider({required SongsService songsService}) : _songsService = songsService;

  final PagingController<int, SongModel> _pagingController = PagingController(firstPageKey: 1);
  final _pageSize = Config.songsPageSize;

   PagingController<int, SongModel> get songsController => _pagingController;
  

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
    final response = await _songsService.fetchSongs(page: page);
    if(response.isFailed){
      _pagingController.error = response.message;
      return;
    }
    final isLastPage = response.model!.length < _pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(response.model!);
    } else {
      final nextPage = page + 1;
      _pagingController.appendPage(response.model!, nextPage);
    }
  }

  // @override
  // void dispose() {
  //   _pagingController.dispose();
  //   super.dispose();
  // }
}