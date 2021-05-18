import 'package:dio/dio.dart';

abstract class ApiInterface {

  Future<List<T>> getCollectionData<T>({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(Map<String, dynamic> responseBody) builder,
  });

  Future<T> getDocumentData<T>({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(Map<String, dynamic> responseBody) builder,
  });

  Future<T> setData<T>({
    required String endpoint,
    required Map<String, dynamic> data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(Map<String, dynamic> response) builder,
  });

  Future<T> updateData<T>({
    required String endpoint,
    required Map<String, dynamic> data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(Map<String, dynamic> response) builder,
  });

  Future<T> deleteData<T>({
    required String endpoint,
    Map<String, dynamic>? data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(Map<String, dynamic> response) builder,
  });

  void cancelRequests({CancelToken? cancelToken});
}
