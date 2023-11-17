import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injector/injector.dart';

import '/services/session_service.dart';
import '/utils/utils.dart';

final api = addInterceptorsWithotToken(
  Dio(
    BaseOptions(
      baseUrl: Urls.apiUrl,
      validateStatus: (status) {
        return status! < 500;
      },
    ),
  ),
);


final apiLogged = addInterceptors(
  Dio(
    BaseOptions(
      baseUrl: Urls.apiUrl,
      validateStatus: (status) {
        return status! < 500;
      },
    ),
  ),
);


Dio addInterceptorsWithotToken(Dio dio) {
  return dio..interceptors.add(
    InterceptorsWrapper(
      onResponse: (response, handler) {
        Log.g('[Dio Response ✨]:  ${response.toString()}');
        return handler.next(response);
      },
      onRequest: (options, handler) {
        Log.b('[Dio Request ▶]:  ${options.uri.toString()}');
        handler.next(options);
      },
      onError: (error, handler) {
        Log.r('[Dio Error ❌]:  ${error.toString()}');
        if(error.error is SocketException){
          throw const SocketException('SocketException');
        }
        return handler.next(error);
      },
    ),
  );
}


Dio addInterceptors(Dio dio) {
  final interceptors = Interceptors(
    sessionService: Injector.appInstance.get(),
  );
  return dio..interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options, handler) {
        Log.g('[Dio Request ▶]:  ${options.uri.toString()}');
        interceptors.requestInterceptor(options, handler);
      },
      onResponse: (response, handler) {
        Log.b('[Dio Response ✨]:  ${response.toString()}');
        return handler.next(response);
      },
      onError: (error, handler) {
        Log.r('[Dio Error ❌]:  ${error.toString()}');
        if(error.error is SocketException){
          throw const SocketException('SocketException');
        }
        return handler.next(error);
      },
    ),
  );
}


class Interceptors{

  final SessionService _sessionService;
  
  const Interceptors({
    required SessionService sessionService,
    
  }): _sessionService = sessionService;
  

  Future<void>  requestInterceptor(
    RequestOptions options,
    RequestInterceptorHandler handler
  ) async {
    final authModel = await _sessionService.getAuthModel();
    var token = authModel!.token;
    options.headers.addAll({HttpHeaders.authorizationHeader: "bearer $token"});
    return handler.next(options);
  }
}
