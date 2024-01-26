import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';

import 'delete_setlists_provider.dart';



final deleteSetlistsProvider = ChangeNotifierProvider.autoDispose<DeleteSetlistsProvider>((ref) {
  return DeleteSetlistsProvider(
    setlistsService: Injector.appInstance.get(),
  );
});