export '/presentation/features/auth/login/providers/login_provider.dart';
export '/presentation/features/auth/login/providers/login_google_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';

import '/presentation/features/auth/login/providers/login_google_provider.dart';
import '/presentation/features/auth/login/providers/login_provider.dart';

final loginProvider = ChangeNotifierProvider.autoDispose<LoginProvider>((ref) {
  return LoginProvider(
    authService: Injector.appInstance.get(),
    sessionService: Injector.appInstance.get()
  );
});

final loginGoogleProvider = ChangeNotifierProvider.autoDispose<LoginGoogleProvider>((ref) {
  return LoginGoogleProvider(
    authService: Injector.appInstance.get(),
    sessionService: Injector.appInstance.get()
  );
});