import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import 'custom_exception.dart';

class DioService {
  late final Dio _dio;
  late final CancelToken _cancelToken;

  DioService({
    required BaseOptions baseOptions,
    required RequestOptions Function(RequestOptions options) onRequest,
  }) {
    createDio(baseOptions, onRequest);
  }

  void createDio(
    BaseOptions baseOptions,
      RequestOptions Function(RequestOptions options) onRequest,
  ) {
    this._cancelToken = CancelToken();
    _dio = Dio(baseOptions);
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) => handler.next(onRequest(options)),
      ),
    );
  }

  void cancelRequests({CancelToken? cancelToken}) {
    cancelToken == null
        ? _cancelToken.cancel('Cancelled')
        : cancelToken.cancel();
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
    } on SocketException {
      throw FetchDataException('No Internet connection');
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
      print("URL: $endpoint");
      return response.data;
    } on SocketException {
      throw FetchDataException('No Internet connection');
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
    } on SocketException {
      throw FetchDataException('No Internet connection');
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
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }
}
