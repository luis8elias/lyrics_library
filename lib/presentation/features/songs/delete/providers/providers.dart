import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';

import '/presentation/features/songs/delete/providers/delete_song_provider.dart';

final deleteSongProvider = ChangeNotifierProvider.autoDispose<DeleteSongProvider>((ref) {
  return DeleteSongProvider(
    songsService: Injector.appInstance.get(),
  );
});