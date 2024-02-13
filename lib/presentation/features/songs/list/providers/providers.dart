import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';

import '/presentation/features/songs/list/providers/add_to_setlist_list_provider.dart';
import '/presentation/features/songs/list/providers/add_to_setlist_provider.dart';
import '/presentation/features/songs/list/providers/songs_list_provider.dart';

final songsListProvider = ChangeNotifierProvider.autoDispose<SongsListProvider>((ref) {
  return SongsListProvider(
    songsService: Injector.appInstance.get(),
  );
});

final addToSetlistListProvider = ChangeNotifierProvider.autoDispose<AddToSetlistListProvider>((ref) {
  return AddToSetlistListProvider(
    setlistsService: Injector.appInstance.get(),
    setlistSongsService: Injector.appInstance.get()
  );
});

final addToSetlistProvider = ChangeNotifierProvider.autoDispose<AddToSetlistProvider>((ref) {
  return AddToSetlistProvider(
    setlistSongsService: Injector.appInstance.get()
  );
});