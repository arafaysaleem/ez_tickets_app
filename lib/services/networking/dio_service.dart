import 'dart:async';

import 'package:dio/dio.dart';

//Exceptions
import 'network_exception.dart';

/// A service class that wraps the [Dio] instance and provides methods for
/// basic network requests.
class DioService {
  /// An instance of [Dio] for executing network requests.
  late final Dio _dio;

  /// An instance of [CancelToken] used to pre-maturely cancel
  /// network requests.
  late final CancelToken _cancelToken;

  /// A public constructor that is used to create a Dio service and initialize
  /// the underlying [Dio] client.
  ///
  /// Attaches any external [Interceptor]s to the underlying [_dio] client.
  DioService({required Dio dioClient, Iterable<Interceptor>? interceptors})
  : _dio = dioClient, _cancelToken = CancelToken() {
    if (interceptors != null) _dio.interceptors.addAll(interceptors);
  }

  /// This method invokes the [cancel()] method on either the input
  /// [cancelToken] or internal [_cancelToken] to pre-maturely end all
  /// requests attached to this token.
  void cancelRequests({CancelToken? cancelToken}) {
    if (cancelToken == null) {
      _cancelToken.cancel('Cancelled');
    } else {
      cancelToken.cancel();
    }
  }

  /// This method sends a `GET` request to the [endpoint] and returns the
  /// **decoded** response.
  ///
  /// Any errors encountered during the request are caught and a custom
  /// [NetworkException] is thrown.
  ///
  /// [queryParams] holds any query parameters for the request.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [options] are special instructions that can be merged with the request.
  Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        endpoint,
        queryParameters: queryParams,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.data as Map<String, dynamic>;
    } on Exception catch (ex) {
      throw NetworkException.getDioException(ex);
    }
  }

  /// This method sends a `POST` request to the [endpoint] and returns the
  /// **decoded** response.
  ///
  /// Any errors encountered during the request are caught and a custom
  /// [NetworkException] is thrown.
  ///
  /// The [data] contains body for the request.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [options] are special instructions that can be merged with the request.
  Future<Map<String, dynamic>> post({
    required String endpoint,
    Map<String, dynamic>? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        endpoint,
        data: data,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.data as Map<String, dynamic>;
    } on Exception catch (ex) {
      throw NetworkException.getDioException(ex);
    }
  }

  /// This method sends a `PATCH` request to the [endpoint] and returns the
  /// **decoded** response.
  ///
  /// Any errors encountered during the request are caught and a custom
  /// [NetworkException] is thrown.
  ///
  /// The [data] contains body for the request.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [options] are special instructions that can be merged with the request.
  Future<Map<String, dynamic>> patch({
    required String endpoint,
    Map<String, dynamic>? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        endpoint,
        data: data,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.data as Map<String, dynamic>;
    } on Exception catch (ex) {
      throw NetworkException.getDioException(ex);
    }
  }

  /// This method sends a `DELETE` request to the [endpoint] and returns the
  /// **decoded** response.
  ///
  /// Any errors encountered during the request are caught and a custom
  /// [NetworkException] is thrown.
  ///
  /// The [data] contains body for the request.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [options] are special instructions that can be merged with the request.
  Future<Map<String, dynamic>> delete({
    required String endpoint,
    Map<String, dynamic>? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>(
        endpoint,
        data: data,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.data as Map<String, dynamic>;
    } on Exception catch (ex) {
      throw NetworkException.getDioException(ex);
    }
  }
}
