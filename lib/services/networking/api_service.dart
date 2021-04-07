import 'package:ez_ticketz_app/providers/all_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dio/dio.dart';

import 'dio_service.dart';

class ApiService {
  late final DioService _dioService;
  final Reader _read;

  ApiService(this._read) {
    final options = BaseOptions(
      baseUrl: "https://ez-tickets-backend.herokuapp.com/",
    );
    _dioService = DioService(
      baseOptions: options,
      onRequest: requestInterceptor,
    );
  }

  // TODO: Expose with riverpod
  // TODO: Implement error handling

  // TODO: Move to custom interceptor
  RequestOptions requestInterceptor(RequestOptions options) {
    if (options.headers.containsKey("requiresAuthToken")) {
      options.headers.remove("requiresAuthToken");

      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // var header = prefs.get("Header");
      final token = _read(authProvider).token;
      options.headers.addAll({'Authorization': 'Bearer $token'});
    }
    return options;
  }

  Future<List<T>> getCollectionData<T>({
    required String path,
    Map<String, dynamic>? queryParams,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(Map<String, dynamic> data) builder,
  }) async {
    //Entire map of response
    final data = await _dioService.get(
      endpoint: path,
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
    required String path,
    Map<String, dynamic>? queryParams,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(Map<String, dynamic> data) builder,
  }) async {
    //Entire map of response
    final data = await _dioService.get(
      endpoint: path,
      queryParams: queryParams,
      options: Options(headers: {"requiresAuthToken": requiresAuthToken}),
      cancelToken: cancelToken,
    );

    //Returning the deserialized object
    return builder(data['body']);
  }

  Future<T> setData<T>({
    required String path,
    required Map<String, dynamic> data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(Map<String, dynamic> response) builder,
  }) async {
    //Entire map of response
    final dataMap = await _dioService.post(
      endpoint: path,
      data: data,
      options: Options(headers: {"requiresAuthToken": requiresAuthToken}),
      cancelToken: cancelToken,
    );

    return builder(dataMap);
  }

  Future<T> updateData<T>({
    required String path,
    required Map<String, dynamic> data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(Map<String, dynamic> response) builder,
  }) async {
    //Entire map of response
    final dataMap = await _dioService.patch(
      endpoint: path,
      data: data,
      options: Options(headers: {"requiresAuthToken": requiresAuthToken}),
      cancelToken: cancelToken,
    );

    return builder(dataMap);
  }

  Future<T> deleteData<T>({
    required String path,
    required Map<String, dynamic> data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(Map<String, dynamic> response) builder,
  }) async {
    //Entire map of response
    final dataMap = await _dioService.patch(
      endpoint: path,
      data: data,
      options: Options(headers: {"requiresAuthToken": requiresAuthToken}),
      cancelToken: cancelToken,
    );

    return builder(dataMap);
  }
}
