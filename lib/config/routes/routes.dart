import 'package:go_router/go_router.dart';
import '/presentation/presentation.dart';

final routes =  [

  GoRoute(
    path: LoadingScreen.routeName,
    name: LoadingScreen.routeName,
    builder: (context, state) => const LoadingScreen(),
  ),

  GoRoute(
    path: HomeScreen.routeName,
    name: HomeScreen.routeName,
    builder: (context, state) => const HomeScreen(),
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
    path: 
    SongsListScreen.routeName,
    name: SongsListScreen.routeName,
    builder: (context, state) => const SongsListScreen(),
  ),

];