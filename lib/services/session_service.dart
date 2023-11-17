import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '/services/base_service.dart';
import '/presentation/features/auth/shared/models/auth_model.dart';
import '/utils/utils.dart';

class SessionService extends BaseService{

  final _authModelKey = 'AUTH_MODEL_KEY';
  final _firstTimeKey = 'FIRST_TIME_KEY';
  final _storage = const FlutterSecureStorage();

  
  Future<void> saveAuthModel({required AuthModel authModel}) async {
    try {
      final encodedAuthModel = json.encode(authModel.toMap());
      await _storage.write(key: _authModelKey, value: encodedAuthModel);
    } catch (e) {
      Log.y('🤡  ${e.toString()}');
      Log.y('😭 Error en SessionService método [saveAuthModel]');
    }
  }


  Future<void> deletesAuthModel() async{
    try {
      await _storage.delete(key: _authModelKey);
    } catch (e) {
      Log.y('🤡  ${e.toString()}');
      Log.y('😭 Error en SessionService método [deletesAuthModel]');
    }
  }
  

  Future<AuthModel?> getAuthModel() async {
    try {
      final authModelStr = await _storage.read(key: _authModelKey);
      if (authModelStr == null || authModelStr == '') throw Exception();
      final authModelMap = json.decode(authModelStr);
      return AuthModel.fromMap(authModelMap);
    } catch (e) {
      Log.y('🤡  ${e.toString()}');
      Log.y('😭 Error en SessionService método [getAuthModel]');
      return null;
    }
  }

  Future<bool> itsTheFirstTime() async {
    try {
      final firstTime = await _storage.read(key: _firstTimeKey);
      if (firstTime == null || firstTime == '') throw Exception();
      final firstTimeValue = json.decode(firstTime) as bool;
      return firstTimeValue;
    } catch (e) {
      Log.y('🤡  ${e.toString()}');
      Log.y('😭 Error en SessionService método [itsTheFirstTime]');
      return true;
    }
  }

  Future<void> setFirstTime() async {
    try {
      final value = false.toString();
      await _storage.write(key: _firstTimeKey, value: value);
    } catch (e) {
      Log.y('🤡  ${e.toString()}');
      Log.y('😭 Error en SessionService método [setFirstTime]');
    }
  }

  Future<void> deleteFirstTime() async{
    try {
      await _storage.delete(key: _firstTimeKey);
    } catch (e) {
      Log.y('🤡  ${e.toString()}');
      Log.y('😭 Error en SessionService método [deleteFirstTime]');
    }
  }

}
