import 'package:flutter/material.dart';

import '/data/data_sources/local/config_local_source.dart';
import '/data/models/response_model.dart';

class ConfigService{

  final ConfigLocalSource _configLocalSource;

  ConfigService({
    required ConfigLocalSource configLocalSource
  }) : _configLocalSource = configLocalSource;


  Future<ResponseModel<double>> getFontSize(){
    return _configLocalSource.getFontSize();
  }

  Future<ResponseModel> setFontSize({
    required double fontSize
  }){
    return _configLocalSource.setFontSize(
      fontSize: fontSize
    );
  }

   Future<ResponseModel<Locale>> getCurrentLanguage(){
    return _configLocalSource.getCurrentLanguage();
  }

  Future<ResponseModel> setLanguage({
    required String languageCode
  }){
    return _configLocalSource.setLanguage(
      languageCode: languageCode
    );
  }
}