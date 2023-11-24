import 'package:flutter_guid/flutter_guid.dart';

import '/services/songs_service.dart';
import '/presentation/providers/send_provider.dart';

class DeleteSongProvider extends SendProvider<String?>{
  final SongsService _songsService;

  DeleteSongProvider({
    required SongsService songsService
  }) : _songsService = songsService;

  Future<void> deleteSongs({
    required List<Guid> songsIds
  }) async {

    applyStatus(SendStatus.loading);
    final deleteSongResp = await _songsService.deleteSongs(
      songsIds: songsIds
    );
    message = deleteSongResp.message ?? '';
    if(deleteSongResp.isFailed){
      return  applyStatus(SendStatus.failed);
    }
    model = deleteSongResp.model;
    return  applyStatus(SendStatus.success);
  }
}