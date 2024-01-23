import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/app/providers/providers.dart';
import '/presentation/presentation.dart';

FutureOr<String?> redirect(
  BuildContext context, 
  GoRouterState goRouterState,
  WidgetRef ref
){

  final providerRoute = ref.watch(sessionProvider).state.route;

  if (goRouterState.fullPath == providerRoute) {
    return null;
  }

  if(goRouterState.path == LoginScreen.routeName ){
    return LoginScreen.routeName;
  }

  final logoutScreens = [
    MenuOptionsScreen.routeName,
  ];

  if(logoutScreens.contains(goRouterState.fullPath) &&  providerRoute == LoginScreen.routeName){
    return providerRoute;
  }


  final provStateRoutes = [
    //LandingScreen.routeName,
    LoadingScreen.routeName,
    LoginScreen.routeName,
    HomeScreen.routeName,
  ];

  if (provStateRoutes.contains(goRouterState.fullPath)) {
    return providerRoute;
  }
  return null;
}