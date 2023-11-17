import 'dart:io';
import 'package:dio/dio.dart';

import '/data/models/response_model.dart';
import '/utils/utils.dart';

class ApiHelper{

  static Future<ResponseModel<T>> call<T>({
    required Future<Response<dynamic>> Function() dioInstanceAndMethod,
    T Function (dynamic json)? modelConvert,
    required String exceptionMessage,
    required String logExceptionMessage,
  })async{

    try{
      final response = await dioInstanceAndMethod();
      final resp = response.data;
      final message = resp['message'] ?? '';
      if (resp['success']) {
        return ResponseModel(
          success: resp['success'],
          message: message,
          model: modelConvert == null ? resp['model'] : modelConvert(resp['model'])
        );
      } else {
        return ResponseModel(
          success: false,
          message: message
        );
      }
    } catch (e) {

      if( e is DioException && e.error is SocketException){
        Log.y('😭 $logExceptionMessage');
        return ResponseModel(
          success: false,
          message: 'No tienes internet'
        );
      }

      Log.y('🤡 ${e.toString()}');
      Log.y('😭 $logExceptionMessage');

      return ResponseModel(
        success: false,
        message: exceptionMessage
      );
    }
  }
}