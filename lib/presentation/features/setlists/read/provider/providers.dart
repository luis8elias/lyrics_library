

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';
import 'package:lyrics_library/presentation/features/setlists/read/provider/read_setlists_songs_provider.dart';

final readSetlistSongsProvider = ChangeNotifierProvider.autoDispose<ReadSetlistsProvider>((ref) {
  return ReadSetlistsProvider(
    setlistSongsService: Injector.appInstance.get(),
  );
});