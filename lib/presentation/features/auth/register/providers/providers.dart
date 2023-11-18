export '/presentation/features/auth/register/providers/register_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';
import '/presentation/features/auth/register/providers/register_provider.dart';


final registerProvider = ChangeNotifierProvider.autoDispose<RegisterProvider>((ref) {
  return RegisterProvider(
    authService: Injector.appInstance.get(),
    sessionService: Injector.appInstance.get(),
  );
});