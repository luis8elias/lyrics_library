import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';

import '/presentation/features/setlist_songs/remove/providers/remove_songs_from_setlist_provider.dart';

final removeSongsFromSetlistProvider = ChangeNotifierProvider.autoDispose<RemoveSongsFromSetlistProvider>((ref) {
  return RemoveSongsFromSetlistProvider(
    setlistSongsService: Injector.appInstance.get(),
  );
});