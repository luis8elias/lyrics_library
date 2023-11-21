import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';

import '/presentation/features/genres/edit/providers/edit_genre_provider.dart';

final editGenreProvider = ChangeNotifierProvider<EditGenreProvider>((ref) {
  return EditGenreProvider(
    genresService: Injector.appInstance.get(),
  );
});