import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:injector/injector.dart';

import '/app/providers/providers.dart';
import '/config/config.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    //final themeProv = ref.watch(themeProvider);
    final sessionProv = ref.read(sessionProvider);
    registerRoutes(sessionProv: sessionProv,ref: ref);

    return MaterialApp.router(
      title:'Lyrics App',
      debugShowCheckedModeBanner: true,
      theme: darkTheme,
      routeInformationProvider: Injector.appInstance.get<GoRouter>().routeInformationProvider,
      routeInformationParser: Injector.appInstance.get<GoRouter>().routeInformationParser,
      routerDelegate: Injector.appInstance.get<GoRouter>().routerDelegate,
      localizationsDelegates: const [
        Lang.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: Lang.delegate.supportedLocales,
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        if (supportedLocales.map((e) => e.languageCode).contains(deviceLocale?.languageCode)) {
          return deviceLocale;
        } else {
          return Config.defaultLocale;
        }
      },
      locale: Config.defaultLocale
    );
  }
}