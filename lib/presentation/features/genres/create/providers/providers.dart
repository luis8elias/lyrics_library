import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';

import 'create_genre_provider.dart';



final createGenreProvider = ChangeNotifierProvider<CreateGenreProvider>((ref) {
  return CreateGenreProvider(
    genresService: Injector.appInstance.get(),
  );
});