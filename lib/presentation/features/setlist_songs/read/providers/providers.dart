import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';
import 'package:lyrics_library/presentation/features/setlist_songs/read/providers/read_setlist_song_provider.dart';


final readSetlistSongProvider = ChangeNotifierProvider.autoDispose<ReadSetlistSongProvider>((ref) {
  return ReadSetlistSongProvider(
    setlistSongsService: Injector.appInstance.get(),
  );
});