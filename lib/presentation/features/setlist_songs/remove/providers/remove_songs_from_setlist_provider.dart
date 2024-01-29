import 'package:flutter_guid/flutter_guid.dart';
import 'package:lyrics_library/presentation/providers/send_provider.dart';
import 'package:lyrics_library/services/setlist_songs_service.dart';

class RemoveSongsFromSetlistProvider extends SendProvider<String?>{
  final SetlistSongsService _setlistSongsService;

  RemoveSongsFromSetlistProvider({
    required SetlistSongsService setlistSongsService
  }) : _setlistSongsService = setlistSongsService;

  Future<void> deleteSongs({
    required List<Guid> songsIds,
    required Guid setlistId
  }) async {

    applyStatus(SendStatus.loading);
    final deleteSongResp = await _setlistSongsService.deleteSongs(
      songsIds: songsIds,
      setlistId: setlistId
    );
    message = deleteSongResp.message ?? '';
    if(deleteSongResp.isFailed){
      return  applyStatus(SendStatus.failed);
    }
    model = deleteSongResp.model;
    return  applyStatus(SendStatus.success);
  }
}