import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';

import 'app_provider.dart';



final appProvider = ChangeNotifierProvider<AppProvider>((ref) {
  return AppProvider(
    sessionService: Injector.appInstance.get(),
    authService: Injector.appInstance.get(),
    configService: Injector.appInstance.get()
  )..checkIfUserIsAuthenticated();
});




