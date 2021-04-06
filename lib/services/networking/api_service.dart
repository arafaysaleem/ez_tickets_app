import 'package:dio/dio.dart';

import 'http_service.dart';

class ApiService {
  final String _baseUrl = "https://ez-tickets-backend.herokuapp.com/";
  final HttpService _httpService = HttpService();

  ApiService._();

  /// Singleton instance of a ApiService class.
  /// TODO: Expose with riverpod
  static final instance = ApiService._();

  Uri getUri(String path, Map<String, dynamic>? queryParameters) => Uri.https(_baseUrl, path, queryParameters);

  Future<List<T>> collection<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic> data) builder,
  }) async {
    final Uri uri = getUri(path, queryParameters);

    //Entire map of response
    final data = await _httpService.get(uri);

    //Items of table as json
    final List<dynamic> items = data['items'];

    //Streaming the deserialized objects
    return items.map((dataMap) => builder(dataMap)).toList();
  }

  Future<T> documentFuture<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic> data) builder,
  }) async {
    final Uri uri = getUri(path, queryParameters);
    //Table item map
    final data = await _httpService.get(uri);

    //Items of table as json
    final List<dynamic> items = data['items'];

    //Returning the promise of the deserialized objects
    return builder(items[0]);
  }

  Future<T> setData<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    required Map<String, dynamic> data,
    required T Function(Map<String, dynamic> response) builder,
  }) async {
    final Uri uri = getUri(path, queryParameters);

    //Entire map of response
    final dataMap = await _httpService.post(uri, data);

    return builder(dataMap);
  }

  Future<T> updateData<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    required Map<String, dynamic> data,
    required T Function(Map<String, dynamic> response) builder,
  }) async {
    final Uri uri = getUri(path, queryParameters);

    //Entire map of response
    final dataMap = await _httpService.put(uri, data);

    return builder(dataMap);
  }

  Future<T> deleteData<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic> response) builder,
  }) async {
    final Uri uri = getUri(path, queryParameters);

    //Entire map of response
    final dataMap = await _httpService.delete(uri);

    return builder(dataMap);
  }
}