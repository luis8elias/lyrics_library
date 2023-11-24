import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';

import '/presentation/features/songs/create/providers/create_song_provider.dart';

final createSongProvider = ChangeNotifierProvider<CreateSongProvider>((ref) {
  return CreateSongProvider(
    songsService: Injector.appInstance.get(),
  );
});