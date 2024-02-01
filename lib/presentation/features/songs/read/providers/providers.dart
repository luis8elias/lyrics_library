import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';

import '/presentation/features/songs/read/providers/read_song_provider.dart';

final readSongProvider = ChangeNotifierProvider.autoDispose<ReadSongProvider>((ref) {
  return ReadSongProvider(
    configService: Injector.appInstance.get(),
  );
});