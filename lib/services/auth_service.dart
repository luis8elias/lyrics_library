import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';

import '/presentation/features/auth/register/models/register_model.dart';
import '/config/config.dart';
import '/utils/logger/logger_helper.dart';
import '/presentation/features/auth/login/models/login_model.dart';
import '/presentation/features/auth/shared/models/auth_model.dart';
import '/data/models/response_model.dart';
import '/services/device_info_service.dart';
import '/utils/api/api_instances.dart';

class AuthService extends DeviceInfoService{
  
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: Config.androidClientId,
    serverClientId: Config.serverClientID,
  );

  Future<ResponseModel<AuthModel>> login({
    required LoginModel loginModel,
  }) async {
    
    final body = loginModel.toMap();
    //body['deviceInfo'] = (await getDeviceInfo()).toMap();

    return apiCall<AuthModel>(
      dioInstanceAndMethod: () => api.post(
        '/Auth/LoginWithEmailAndPassword',
        data: jsonEncode(body)
      ),
      modelConvert: (json) => AuthModel.fromMap(json), 
      exceptionMessage: 'No se pudo hacer login', 
      logExceptionMessage: 'Error en AuthService método [login]'
    );
    
  }

  Future<ResponseModel<AuthModel>> loginGoogle() async {

    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }

    if (idToken == null) {
      throw 'No ID Token found.';
    }

    final body = {
      "email": googleUser.email,
      "displayName": googleUser.displayName,
      "idToken": idToken,
      "accessToken": accessToken
    };

    return apiCall<AuthModel>(
      dioInstanceAndMethod: () => api.post(
        '/Auth/LoginWithGoogle',
        data: jsonEncode(body)
      ),
      modelConvert: (json) => AuthModel.fromMap(json), 
      exceptionMessage: 'No se pudo hacer login con google', 
      logExceptionMessage: 'Error en AuthService método [loginGoogle]'
    );
      
  }

  Future<ResponseModel> logout() async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final isLoggedinWihtGoogle = await _googleSignIn.isSignedIn();
      if(isLoggedinWihtGoogle){
        await _googleSignIn.signOut();
      }
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

  Future<ResponseModel<AuthModel?>> register({
    required RegisterModel registerModel
  }) async {

    return apiCall<AuthModel>(
      dioInstanceAndMethod: () => api.post(
        '/Auth/Register',
        data: jsonEncode(registerModel.toMapToApi())
      ),
      modelConvert: (json) => AuthModel.fromMap(json), 
      exceptionMessage: 'No se pudo registrar', 
      logExceptionMessage: 'Error en AuthService método [register]'
    );
    
  }
}
