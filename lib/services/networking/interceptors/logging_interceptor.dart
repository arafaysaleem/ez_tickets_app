import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {

  @override
  FutureOr<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final httpMethod = options.method.toUpperCase();
    final url = options.baseUrl + options.path;

    debugPrint("--> $httpMethod $url"); //GET www.example.com/mock_path/all

    debugPrint("Headers:");
    options.headers.forEach((k, v) => debugPrint('\t$k: $v'));

    debugPrint("queryParams:");
    options.queryParameters.forEach((k, v) => debugPrint('\t$k: $v'));

    if (options.data != null) {
      debugPrint("Body: ${options.data}");
    }

    debugPrint("--> END $httpMethod");

    return options;
  }

  @override
  FutureOr<dynamic> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    final statusCode = response.statusCode;
    final url = response.requestOptions.baseUrl + response.requestOptions.path;

    debugPrint("<-- $statusCode $url"); //GET www.example.com/mock_path/all

    debugPrint("Headers:");
    response.headers.forEach((k, v) => debugPrint('\t$k: $v'));

    debugPrint("Response: ${response.data}");

    debugPrint("<-- END HTTP");
  }

  @override
  FutureOr<dynamic> onError(
    DioError dioError,
    ErrorInterceptorHandler handler,
  ) {
    final message = dioError.message;
    String? url;

    if (dioError.response != null) {
      url = dioError.response!.requestOptions.baseUrl +
          dioError.response!.requestOptions.path;
    }

    debugPrint("<-- $message ${url ?? "URL"}");

    debugPrint("${dioError.response?.data ?? 'Unknown Error'}");

    debugPrint("<-- End error");
  }
}
