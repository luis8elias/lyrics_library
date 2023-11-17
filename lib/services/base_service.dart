import 'package:dio/dio.dart';

import '/data/models/response_model.dart';
import '/utils/api/api_helper.dart';


abstract class BaseService{

  

  Future<ResponseModel<T>> apiCall<T>({
    required Future<Response<dynamic>> Function() dioInstanceAndMethod,
    T Function (dynamic json)? modelConvert,
    required String exceptionMessage,
    required String logExceptionMessage,
  }){
    return ApiHelper.call(
      dioInstanceAndMethod: dioInstanceAndMethod, 
      exceptionMessage: exceptionMessage, 
      logExceptionMessage: logExceptionMessage,
      modelConvert: modelConvert
    );
  }
}