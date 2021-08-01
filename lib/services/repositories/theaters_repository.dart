import 'package:dio/dio.dart';

//models
import '../../models/theater_model.dart';

//services
import '../networking/api_endpoint.dart';
import '../networking/api_service.dart';

class TheatersRepository {
  final ApiService _apiService;
  final CancelToken? _cancelToken;

  TheatersRepository({
    required ApiService apiService,
    CancelToken? cancelToken,
  })  : _apiService = apiService,
        _cancelToken = cancelToken;

  Future<List<TheaterModel>> fetchAll({
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _apiService.getCollectionData<TheaterModel>(
      endpoint: ApiEndpoint.theaters(TheaterEndpoint.BASE),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => TheaterModel.fromJson(responseBody),
    );
  }

  Future<TheaterModel> fetchOne({
    required int theaterId,
  }) async {
    return await _apiService.getDocumentData<TheaterModel>(
      endpoint: ApiEndpoint.theaters(TheaterEndpoint.BY_ID, id: theaterId),
      cancelToken: _cancelToken,
      converter: (responseBody) => TheaterModel.fromJson(responseBody),
    );
  }

  Future<int> create({
    required Map<String, dynamic> data,
  }) async {
    return await _apiService.setData<int>(
      endpoint: ApiEndpoint.theaters(TheaterEndpoint.BASE),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['body']['theater_id'] as int,
    );
  }

  Future<String> update({
    required int theaterId,
    required Map<String, dynamic> data,
  }) async {
    return await _apiService.updateData<String>(
      endpoint: ApiEndpoint.theaters(TheaterEndpoint.BY_ID, id: theaterId),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  Future<String> delete({
    required int theaterId,
    Map<String, dynamic>? data,
  }) async {
    return await _apiService.deleteData<String>(
      endpoint: ApiEndpoint.theaters(TheaterEndpoint.BY_ID, id: theaterId),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  void cancelRequests() {
    _apiService.cancelRequests(cancelToken: _cancelToken);
  }
}
