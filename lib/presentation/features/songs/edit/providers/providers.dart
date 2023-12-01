import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';

import '/presentation/features/songs/edit/providers/edit_song_provider.dart';

final editSongProvider = ChangeNotifierProvider<EditSongProvider>((ref) {
  return EditSongProvider(
    songsService: Injector.appInstance.get(),
  );
});