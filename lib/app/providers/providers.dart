import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';

import '/app/providers/session_provider.dart';

final sessionProvider = ChangeNotifierProvider<SessionProvider>((ref) {
  return SessionProvider(
    sessionService: Injector.appInstance.get(),
    authService: Injector.appInstance.get()
  )..checkIfUserIsAuthenticated();
});