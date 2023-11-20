import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';

import '/presentation/features/genres/delete/providers/delete_genre_provider.dart';

final deleteGenreProvider = ChangeNotifierProvider.autoDispose<DeleteGenreProvider>((ref) {
  return DeleteGenreProvider(
    genreService: Injector.appInstance.get(),
  );
});