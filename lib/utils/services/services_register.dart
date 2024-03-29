import 'package:injector/injector.dart';

import '/data/data_sources/local/config_local_source.dart';
import '/data/data_sources/local/genres_local_source.dart';
import '/data/data_sources/local/metrics_local_source.dart';
import '/data/data_sources/local/setlist_songs_local_source.dart';
import '/data/data_sources/local/setlists_local_source.dart';
import '/data/data_sources/local/songs_local_source.dart';
import '/services/auth_service.dart';
import '/services/config_service.dart';
import '/services/genres_service.dart';
import '/services/metrics_service.dart';
import '/services/session_service.dart';
import '/services/setlist_songs_service.dart';
import '/services/setlists_service.dart';
import '/services/songs_service.dart';

class ServicesRegister{
  static void start(){

    
    Injector.appInstance.registerSingleton<SessionService>(
      () => SessionService()
    );

    //Sources
    //Api
    //Local
    Injector.appInstance.registerSingleton<GenresLocalSource>(
      () => GenresLocalSource(
        sessionService: Injector.appInstance.get()
      )
    );
    Injector.appInstance.registerSingleton<SongsLocalSource>(
      () => SongsLocalSource(
        sessionService: Injector.appInstance.get()
      )
    );
    Injector.appInstance.registerSingleton<SetlistsLocalSource>(
      () => SetlistsLocalSource(
        sessionService: Injector.appInstance.get()
      )
    );
    Injector.appInstance.registerSingleton<SetlistSongsLocalSource>(
      () => SetlistSongsLocalSource(
        sessionService: Injector.appInstance.get()
      )
    );
    Injector.appInstance.registerSingleton<ConfigLocalSource>(
      () => ConfigLocalSource()
    );
    Injector.appInstance.registerSingleton<MetricsLocalSource>(
      () => MetricsLocalSource()
    );

    //Services
    Injector.appInstance.registerSingleton<GenresService>(
      () => GenresService(
        localSource: Injector.appInstance.get()
      )
    );
    Injector.appInstance.registerSingleton<AuthService>(
      () => AuthService()
    );
    Injector.appInstance.registerSingleton<SongsService>(
      () => SongsService(
        localSource: Injector.appInstance.get()
      )
    );
    Injector.appInstance.registerSingleton<SetlistsService>(
      () => SetlistsService(
        localSource: Injector.appInstance.get()
      )
    );
    Injector.appInstance.registerSingleton<SetlistSongsService>(
      () => SetlistSongsService(
        localSource: Injector.appInstance.get()
      )
    );
    Injector.appInstance.registerSingleton<ConfigService>(
      () => ConfigService(
        configLocalSource: Injector.appInstance.get()
      )
    );
    Injector.appInstance.registerSingleton<MetricsService>(
      () => MetricsService(
        localSource: Injector.appInstance.get()
      )
    );

    
  }
}