import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';

import '/presentation/features/more/scan_song/providers/save_scanned_song_provider.dart';
import '/presentation/features/more/scan_song/providers/scan_song_provider.dart';

final scanSongProvider = ChangeNotifierProvider.autoDispose<ScanSongProvider>((ref) {
  return ScanSongProvider();
});

final saveScannedSongProvider = ChangeNotifierProvider.autoDispose<SavedScannedSongProvider>((ref) {
  return SavedScannedSongProvider(
    songsService: Injector.appInstance.get()
  );
});