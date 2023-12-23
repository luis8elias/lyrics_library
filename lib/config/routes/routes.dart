import 'package:go_router/go_router.dart';


import '/config/routes/custom_transiton_page.dart';
import '/presentation/features/genres/shared/models/genre_model.dart';
import '/presentation/features/songs/shared/model/song_model.dart';
import '/presentation/presentation.dart';

final routes =  [

  GoRoute(
    path: LoadingScreen.routeName,
    name: LoadingScreen.routeName,
    builder: (context, state) => const LoadingScreen(),
  ),

  GoRoute(
    path: LoginScreen.routeName,
    name: LoginScreen.routeName,
    builder: (context, state) => const LoginScreen(),
    routes: [
      GoRoute(
        path: RegisterScreen.routeName,
        name: RegisterScreen.routeName,
        builder: (context, state) => const RegisterScreen(),
      ),
    ]
  ),

  GoRoute(
    path: HomeScreen.routeName,
    name: HomeScreen.routeName,
    pageBuilder: (context, state) => buildPageWithDefaultTransition(
      state: state,
      context: context,
      child: const HomeScreen()
    ),
  ),

  

  GoRoute(
    path: 
    SongsListScreen.routeName,
    name: SongsListScreen.routeName,
    pageBuilder: (context, state) => buildPageWithDefaultTransition(
      state: state,
      context: context,
      child: const SongsListScreen()
    ),
    routes: [
      GoRoute(
        path: CreateSongScreen.routePath,
        name: CreateSongScreen.routeName,
        builder: (context, state) => const CreateSongScreen(),
      ),
      GoRoute(
        path: EditSongScreen.routePath,
        name: EditSongScreen.routeName,
        builder: (context, state) => EditSongScreen(
          songModel: state.extra as SongModel,
        ),
      ),
      GoRoute(
        path: ReadSongScreen.routePath,
        name: ReadSongScreen.routeName,
        builder: (context, state) => ReadSongScreen(
          songModel: state.extra as SongModel,
        ),
      ),
    ]
  ),

  GoRoute(
    path: GenresListScreen.routeName,
    name: GenresListScreen.routeName,
    pageBuilder: (context, state) => buildPageWithDefaultTransition(
      state: state,
      context: context,
      child: const GenresListScreen()
    ),
    routes: [
      GoRoute(
        path: CreateGenreScreen.routePath,
        name: CreateGenreScreen.routeName,
        builder: (context, state) => const CreateGenreScreen(),
      ),
      GoRoute(
        path: EditGenreScreen.routePath,
        name: EditGenreScreen.routeName,
        builder: (context, state) => EditGenreScreen(
          genreModel: state.extra as GenreModel,
        ),
      )
    ]
  ),

];