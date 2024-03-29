
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '/config/config.dart';
import '/data/models/response_model.dart';
import '/utils/utils.dart';

class ConfigLocalSource{

  final _storage = const FlutterSecureStorage();
  final _fontSizeKey = 'FONT_SIZE_KEY';
  final _langKey = 'LANG_KEY';

  Future<ResponseModel<double>> getFontSize() async{

    try {
      final fontSize = await _storage.read(key: _fontSizeKey);
      return ResponseModel(
        success: true,
        model:  double.parse(fontSize ?? Config.defaultReadSongFontSize.toString() )
      );
    } catch (e) {

      Log.y('🤡  ${e.toString()}');
      Log.y('😭 Error en ConfigLocalSource método [getFontSize]');

      return ResponseModel(
        success: true,
        model:  double.parse(Config.defaultReadSongFontSize.toString())
      );
    }
  }

  Future<ResponseModel> setFontSize({
    required double fontSize
  }) async{

    try {
      await _storage.write(
        key: _fontSizeKey,
        value: fontSize.toString()
      );
      return ResponseModel(
        success: true,
        message: 'Tamaño de fuente guardada',
      );
    } catch (e) {

      Log.y('🤡  ${e.toString()}');
      Log.y('😭 Error en ConfigLocalSource método [setFontSize]');

      return ResponseModel(
        success: false,
        message: 'No se pudo guardar el tamaño de fuente'
      );
    }
  }

  Future<ResponseModel<Locale>> getCurrentLanguage() async{

    try {
      final lang = await _storage.read(key: _langKey);
      return ResponseModel(
        success: true,
        model:  Locale(lang!)
      );
    } catch (e) {

      Log.y('🤡  ${e.toString()}');
      Log.y('😭 Error en ConfigLocalSource método [getCurrentLang]');

      return ResponseModel(
        success: true,
        model: Config.defaultLocale
      );
    }
  }


  Future<ResponseModel> setLanguage({
    required String languageCode
   }) async{

    try {
      await _storage.write(
        key: _langKey,
        value: languageCode
      );
      return ResponseModel(
        success: true,
        message: 'Lenguaje guardado',
      );
    } catch (e) {

      Log.y('🤡  ${e.toString()}');
      Log.y('😭 Error en ConfigLocalSource método [setLanguage]');

      return ResponseModel(
        success: false,
        message: 'No se pudo guardar el lenguaje'
      );
    }
  }

}