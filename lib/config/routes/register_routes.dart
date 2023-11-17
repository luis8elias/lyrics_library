import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:injector/injector.dart';

import '/config/routes/redirect.dart';
import '/app/providers/session_provider.dart';
import '/config/config.dart';

void registerRoutes({
  required SessionProvider sessionProv,
  required WidgetRef ref
}){

  if (!Injector.appInstance.exists<GoRouter>()) {
    Injector.appInstance.registerSingleton<GoRouter>(() {
      return GoRouter(
        debugLogDiagnostics: true,
        routes: routes,
        initialLocation: Config.initialLocation,
        refreshListenable: sessionProv,
        redirect: (context, state) => redirect(context, state, ref),
      );
    });
  }

}