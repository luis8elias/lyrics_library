import '/presentation/presentation.dart';


enum SessionState{
  firstTime(LoginScreen.routeName),
  loading(LoadingScreen.routeName),
  unauthenticatedUser(LoginScreen.routeName),
  authenticatedUser(SongsListScreen.routeName);
  
  final String route;
  const SessionState(this.route);
}