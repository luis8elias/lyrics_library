import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';

import '/presentation/features/genres/list/providers/genres_list_provider.dart';

final genresListProvider = ChangeNotifierProvider.autoDispose<GenresListProvider>((ref) {
  return GenresListProvider(
    genresService: Injector.appInstance.get(),
  );
});