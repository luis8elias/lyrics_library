import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '/config/config.dart';
import '/presentation/features/auth/login/models/login_google_resp.dart';
import '/utils/logger/logger_helper.dart';

import '/presentation/features/auth/login/models/login_model.dart';
import '/presentation/features/auth/shared/models/auth_model.dart';
import '/data/models/response_model.dart';
import '/services/device_info_service.dart';
import '/utils/api/api_instances.dart';

class AuthService extends DeviceInfoService{

  final supabase = Supabase.instance.client;

  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: Config.androidClientId,
    serverClientId: Config.serverClientID,
  );

  Future<ResponseModel<AuthModel>> login({
    required LoginModel loginModel,
  }) async {
    
    final body = loginModel.toMap();
    body['deviceInfo'] = (await getDeviceInfo()).toMap();

    return apiCall<AuthModel>(
      dioInstanceAndMethod: () => api.post(
        '/auth/login',
        data: jsonEncode(body)
      ),
      modelConvert: (json) => AuthModel.fromMap(json), 
      exceptionMessage: 'No se pudo hacer login', 
      logExceptionMessage: 'Error en AuthService método [login]'
    );
  }

  Future<ResponseModel<LoginGoogleResp>> loginGoogle() async {

    try {
     
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }
      
      final supabaseLoginResp = await supabase.auth.signInWithIdToken(
        provider: Provider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      return ResponseModel(
        success: true,
        message: 'Login with Google success',
        model: LoginGoogleResp(
          userId: supabaseLoginResp.user!.id,
          authModel: AuthModel(
            token: supabaseLoginResp.session!.accessToken, 
            refreshToken: supabaseLoginResp.session!.refreshToken!
          ),
          displayName: googleUser.displayName ?? 'Nombre no disponible',
          email: googleUser.email
        )
      );
    } catch (e) {
    
      Log.y('🤡 ${e.toString()}');
      Log.y('😭 Error en AuthService método [loginGoogle]');

      return ResponseModel(
        success: false,
        message: 'No se pudo hacer login'
      );
    }
    
  }

  Future<ResponseModel> logout() async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final isLoggedinWihtGoogle = await googleSignIn.isSignedIn();
      if(isLoggedinWihtGoogle){
        await googleSignIn.signOut();
      }
      await supabase.auth.signOut();
      
      return ResponseModel(
        success: true,
        message: 'Cerrar sesión exitoso'
      );
    } catch (e) {

      Log.y('🤡 ${e.toString()}');
      Log.y('😭 Error en AuthService método [logout]');

      return ResponseModel(
        success: false,
        message: 'Ocurrió un probelma al cerrar sesión'
      );
    }
    
  }

}
