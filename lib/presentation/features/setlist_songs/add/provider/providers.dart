import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';

import '/presentation/features/setlist_songs/add/provider/add_song_to_setlist_list_provider.dart';

final addSetlistSongsListProvider = ChangeNotifierProvider.autoDispose<AddSongToSetlistListProvider>((ref) {
  return AddSongToSetlistListProvider(
    setlistSongsService: Injector.appInstance.get(),
  );
});

