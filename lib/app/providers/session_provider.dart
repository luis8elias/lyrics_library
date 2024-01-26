import 'dart:developer';

import 'package:flutter/material.dart';

import '/data/enums/session_status.dart';
import '/presentation/features/auth/shared/models/auth_model.dart';
import '/services/auth_service.dart';
import '/services/session_service.dart';
import '/utils/db/sqlite.dart';

class SessionProvider extends  ChangeNotifier{
  final SessionService _sessionService;
  final AuthService _authService;
 
  SessionProvider({
    required SessionService sessionService,
    required AuthService authService
  })
  :
  _sessionService = sessionService,
  _authService = authService;
 



  SessionState state = SessionState.loading;
  bool isTheFirstTime = true;
  bool isLoadingLogout = false;
  AuthModel? userSession;


  set setIsLoadingLogout(bool newValue){
    isLoadingLogout = newValue;
  }

  

  void _applyState(SessionState newState){
    if(state == newState){
      return;
    }
    log('[SessionStateUpdate✨] prevState: [${state.name}] => newState: [${newState.name}]');
    state = newState;
    notifyListeners();
  }



  Future<void> checkIfUserIsAuthenticated() async{
    setIsLoadingLogout = false;
    final isTheFirstTimeResp = await _sessionService.itsTheFirstTime();
    isTheFirstTime = isTheFirstTimeResp;

    if(isTheFirstTime){
      return  _applyState(SessionState.firstTime);
    }
    
    final authModel = await _sessionService.getAuthModel();
    if (authModel == null) {
      return _applyState(SessionState.unauthenticatedUser);
    }
    userSession = authModel;
    await SQLite.seedTables(authModel.userId);
    return _applyState(SessionState.authenticatedUser);
  }



  Future<void> logoutUser() async{
    isLoadingLogout = true;
    notifyListeners();
    final logoutResp = await _authService.logout();
    if(logoutResp.success){
      await _sessionService.deletesAuthModel();
      userSession = null;
      _applyState(SessionState.unauthenticatedUser);
    }
  }

}
