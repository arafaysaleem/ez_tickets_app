import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final httpMethod = options.method.toUpperCase();
    final url = options.baseUrl + options.path;

    debugPrint("--> $httpMethod $url"); //GET www.example.com/mock_path/all

    debugPrint("\tHeaders:");
    options.headers.forEach((k, v) => debugPrint('\t\t$k: $v'));

    if(options.queryParameters.isNotEmpty){
      debugPrint("\tqueryParams:");
      options.queryParameters.forEach((k, v) => debugPrint('\t\t$k: $v'));
    }

    if (options.data != null) {
      debugPrint("\tBody: ${options.data}");
    }

    debugPrint("--> END $httpMethod");

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {

    debugPrint("<-- RESPONSE");

    debugPrint("\tStatus code:${response.statusCode}");

    debugPrint("\tResponse: ${response.data}");

    debugPrint("<-- END HTTP");

    return super.onResponse(response, handler);
  }

  @override
  void onError(
    DioError dioError,
    ErrorInterceptorHandler handler,
  ) {
    debugPrint("--> ERROR");
    if(dioError.response != null){
      debugPrint("\tStatus code: ${dioError.response!.statusCode}");
      if(dioError.response!.data != null){
        final Map<String,dynamic> headers = dioError.response!.data["headers"];
        String message = headers["message"];
        String error = headers["error"];
        debugPrint("\tException: $error");
        debugPrint("\tMessage: $message");
        if(headers.containsKey("data")){
          List<dynamic> data = headers["data"];
          if(data.isNotEmpty) {
            debugPrint("\tData: $data");
          }
        }
      }
      else {
        debugPrint("${dioError.response!.data}");
      }
    }
    else if(dioError.error is SocketException){
      final message = "No internet connectivity";
      debugPrint("\tException: FetchDataException");
      debugPrint("\tMessage: $message");
    }
    else {
      debugPrint("\tUnknown Error");
    }

    debugPrint("<-- END ERROR");

    return super.onError(dioError, handler);
  }
}
