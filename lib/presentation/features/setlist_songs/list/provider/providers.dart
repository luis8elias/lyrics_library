

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';
import 'package:lyrics_library/presentation/features/setlist_songs/list/provider/setlists_songs_list_provider.dart';

final setlistSongsListProvider = ChangeNotifierProvider.autoDispose<SetlistSongsListProvider>((ref) {
  return SetlistSongsListProvider(
    setlistSongsService: Injector.appInstance.get(),
  );
});