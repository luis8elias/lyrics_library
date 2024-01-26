import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';

import 'create_setlist_provider.dart';



final createSetlistProvider = ChangeNotifierProvider<CreateSetlistProvider>((ref) {
  return CreateSetlistProvider(
    setlistsService: Injector.appInstance.get(),
  );
});