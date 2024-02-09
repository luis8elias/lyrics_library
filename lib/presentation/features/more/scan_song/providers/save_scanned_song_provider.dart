import '/presentation/features/more/scan_song/models/scanned_song_model.dart';
import '/presentation/providers/send_provider.dart';
import '/services/songs_service.dart';

class SavedScannedSongProvider extends SendProvider<String>{
  final SongsService _songsService;

  SavedScannedSongProvider({
    required SongsService songsService
  }) : _songsService = songsService;

  Future<void> saveSong({
    required ScannedSongModel scannedSongModel
  })async{
    applyStatus(SendStatus.loading);
    final response = await _songsService.saveSongFromScan(
      scannedSongModel: scannedSongModel
    );
    if(response.isFailed){
      message = response.message!;
      return applyStatus(SendStatus.failed);
    }
    message = response.message!;
    model = response.model!;
    return applyStatus(SendStatus.success);
  }
}