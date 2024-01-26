import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';

import '/presentation/features/setlists/edit/providers/edit_setlist_provider.dart';



final editSetlistProvider = ChangeNotifierProvider<EditSetlistProvider>((ref) {
  return EditSetlistProvider(
    setlistsService: Injector.appInstance.get(),
  );
});