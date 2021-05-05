import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

//Interceptors
import 'interceptors/api_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/refresh_token_interceptor.dart';
//Exceptions
import 'network_exception.dart';

class DioService {
  late final Dio _dio;
  late final CancelToken _cancelToken;

  DioService({required BaseOptions baseOptions}) {
    createDio(baseOptions);
  }

  void createDio(BaseOptions baseOptions) {
    _cancelToken = CancelToken();
    _dio = Dio(baseOptions);
    _dio.interceptors.addAll([
      ApiInterceptor(),
      if (kDebugMode) LoggingInterceptor(),
      RefreshTokenInterceptor(_dio),
    ]);
  }

  void cancelRequests({CancelToken? cancelToken}) {
    if (cancelToken == null) {
      _cancelToken.cancel('Cancelled');
    } else {
      cancelToken.cancel();
    }
  }

  Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.data;
    } on Exception catch (ex) {
      throw NetworkException.getDioException(ex);
    }
  }

  Future<Map<String, dynamic>> post({
    required String endpoint,
    Map<String, dynamic>? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.data;
    } on Exception catch (ex) {
      throw NetworkException.getDioException(ex);
    }
  }

  Future<Map<String, dynamic>> patch({
    required String endpoint,
    Map<String, dynamic>? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.data;
    } on Exception catch (ex) {
      throw NetworkException.getDioException(ex);
    }
  }

  Future<Map<String, dynamic>> delete({
    required String endpoint,
    Map<String, dynamic>? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.data;
    } on Exception catch (ex) {
      throw NetworkException.getDioException(ex);
    }
  }
}
