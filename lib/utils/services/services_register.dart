import 'package:injector/injector.dart';
import 'package:lyrics_library/data/data_sources/local/genres_local_source.dart';
import 'package:lyrics_library/services/genres_service.dart';
import '/data/data_sources/api/songs_api_source.dart';
//import 'package:lyrics_app/data/data_sources/interfaces/songs_data_source_interface.dart';
import '/services/auth_service.dart';
import '/services/session_service.dart';
import '/services/songs_service.dart';

class ServicesRegister{
  static void start(){

    //Sources
    //Api
    Injector.appInstance.registerSingleton<SongsApiSource>(
      () => SongsApiSource()
    );
    //Local
    Injector.appInstance.registerSingleton<GenresLocalSource>(
      () => GenresLocalSource()
    );

    //Services
    Injector.appInstance.registerSingleton<SessionService>(
      () => SessionService()
    );
    Injector.appInstance.registerSingleton<AuthService>(
      () => AuthService()
    );
    Injector.appInstance.registerSingleton<SongsService>(
      () => SongsService(
        apiSource: Injector.appInstance.get<SongsApiSource>()
      )
    );

    Injector.appInstance.registerSingleton<GenresService>(
      () => GenresService(
        localSource: Injector.appInstance.get<GenresLocalSource>()
      )
    );

    
    
  }
}