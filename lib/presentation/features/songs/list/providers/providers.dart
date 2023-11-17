import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';

import '/presentation/features/songs/list/providers/songs_list_provider.dart';

final songsListProvider = ChangeNotifierProvider.autoDispose<SongsListProvider>((ref) {
  return SongsListProvider(
    songsService: Injector.appInstance.get(),
  );
});