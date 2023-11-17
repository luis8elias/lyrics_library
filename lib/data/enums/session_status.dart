import '/presentation/presentation.dart';


enum SessionState{
  firstTime(LoginScreen.routeName),
  loading(LoadingScreen.routeName),
  unauthenticatedUser(LoginScreen.routeName),
  authenticatedUser(HomeScreen.routeName);
  
  final String route;
  const SessionState(this.route);
}