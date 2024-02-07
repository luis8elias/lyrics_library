import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/config.dart';
import '/data/enums/session_status.dart';
import '/presentation/features/auth/shared/models/auth_model.dart';
import '/services/auth_service.dart';
import '/services/config_service.dart';
import '/services/session_service.dart';
import '/utils/db/sqlite.dart';

class AppProvider extends  ChangeNotifier{
  final SessionService _sessionService;
  final AuthService _authService;
  final ConfigService _configService;
 
  AppProvider({
    required SessionService sessionService,
    required AuthService authService,
    required ConfigService configService
  })
  :
  _sessionService = sessionService,
  _configService = configService,
  _authService = authService;
 



  SessionState state = SessionState.loading;
  bool isTheFirstTime = true;
  bool isLoadingLogout = false;
  AuthModel? userSession;
  Locale? selectedLocale;

  Future<void> _initializeLanguage() async{
    final resp = await _configService.getCurrentLanguage();
    if(resp.isFailed){
      selectedLocale = Config.defaultLocale;
      return;
    }
    selectedLocale = resp.model!;
  }

  Future<void> changeLanguage({
    required Locale locale
  }) async{
    await _configService.setLanguage(
      languageCode: locale.languageCode
    );
    selectedLocale = locale;
    notifyListeners();
  }


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



  Future<void> checkIfUserIsAuthenticated({
    WidgetRef? widgetRef
  }) async{
    setIsLoadingLogout = false;
    final isTheFirstTimeResp = await _sessionService.itsTheFirstTime();
    isTheFirstTime = isTheFirstTimeResp;
    if(selectedLocale == null){
      await _initializeLanguage();
    }
    
    if(isTheFirstTime){
      return  _applyState(SessionState.firstTime);
    }
    
    final authModel = await _sessionService.getAuthModel();
    if (authModel == null) {
      return _applyState(SessionState.unauthenticatedUser);
    }
    userSession = authModel;
    _applyState(SessionState.authenticatedUser);
    await SQLite.seedTables(authModel.userId);
    
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
