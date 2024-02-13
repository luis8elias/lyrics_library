import 'package:flutter_guid/flutter_guid.dart';

import '/presentation/providers/providers.dart';
import '/services/setlist_songs_service.dart';

class AddToSetlistProvider extends SendProvider<dynamic>{

  final SetlistSongsService _setlistSongsService;

  AddToSetlistProvider({
    required SetlistSongsService setlistSongsService
  }) : _setlistSongsService = setlistSongsService;

  Future<void> saveSongInSetlists({
    required List<Guid> setlistIds,
    required List<Guid> prevSelectedIds,
    required Guid songId
  })async {
    applyStatus(SendStatus.loading);

    final resp = await _setlistSongsService.addSongToSetlistFromList(
      setlistIds: setlistIds,
      prevSelectedIds: prevSelectedIds,
      songId: songId
    );
    if(resp.isFailed){
      message = resp.message!;
      return applyStatus(SendStatus.failed);
    }
    message = resp.message!;
    model =resp.model!;
    return applyStatus(SendStatus.success);
  }


}