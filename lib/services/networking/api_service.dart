import 'package:dio/dio.dart';

import 'dio_service.dart';

class ApiService {
  late final DioService _dioService;

  ApiService() {
    final options = BaseOptions(
      baseUrl: "https://ez-tickets-backend.herokuapp.com/api/v1",
    );
    _dioService = DioService(
      baseOptions: options,
    );
  }

  Future<List<T>> getCollectionData<T>({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(Map<String, dynamic> body) builder,
  }) async {
    //Entire map of response
    final data = await _dioService.get(
      endpoint: endpoint,
      options: Options(headers: {"requiresAuthToken": requiresAuthToken}),
      queryParams: queryParams,
      cancelToken: cancelToken,
    );

    //Items of table as json
    final List<dynamic> body = data['body'];

    //Returning the deserialized objects
    return body.map((dataMap) => builder(dataMap)).toList();
  }

  Future<T> getDocumentData<T>({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(Map<String, dynamic> body) builder,
  }) async {
    //Entire map of response
    final data = await _dioService.get(
      endpoint: endpoint,
      queryParams: queryParams,
      options: Options(headers: {"requiresAuthToken": requiresAuthToken}),
      cancelToken: cancelToken,
    );

    //Returning the deserialized object
    return builder(data['body']);
  }

  Future<T> setData<T>({
    required String endpoint,
    required Map<String, dynamic> data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(Map<String, dynamic> response) builder,
  }) async {
    //Entire map of response
    final dataMap = await _dioService.post(
      endpoint: endpoint,
      data: data,
      options: Options(headers: {"requiresAuthToken": requiresAuthToken}),
      cancelToken: cancelToken,
    );

    return builder(dataMap);
  }

  Future<T> updateData<T>({
    required String endpoint,
    required Map<String, dynamic> data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(Map<String, dynamic> response) builder,
  }) async {
    //Entire map of response
    final dataMap = await _dioService.patch(
      endpoint: endpoint,
      data: data,
      options: Options(headers: {"requiresAuthToken": requiresAuthToken}),
      cancelToken: cancelToken,
    );

    return builder(dataMap);
  }

  Future<T> deleteData<T>({
    required String endpoint,
    required Map<String, dynamic> data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(Map<String, dynamic> response) builder,
  }) async {
    //Entire map of response
    final dataMap = await _dioService.patch(
      endpoint: endpoint,
      data: data,
      options: Options(headers: {"requiresAuthToken": requiresAuthToken}),
      cancelToken: cancelToken,
    );

    return builder(dataMap);
  }
}
