import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';

import '/presentation/features/setlists/list/providers/setlists_list_provider.dart';



final setlistsListProvider = ChangeNotifierProvider.autoDispose<SetlistsListProvider>((ref) {
  return SetlistsListProvider(
    setlistsService: Injector.appInstance.get(),
  );
});