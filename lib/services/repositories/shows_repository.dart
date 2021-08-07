import 'package:dio/dio.dart';

//models
import '../../models/show_model.dart';

//services
import '../networking/api_endpoint.dart';
import '../networking/api_service.dart';

//helpers
import '../../helper/typedefs.dart';

class ShowsRepository {
  final ApiService _apiService;
  final CancelToken? _cancelToken;

  ShowsRepository({
    required ApiService apiService,
    CancelToken? cancelToken,
  })  : _apiService = apiService,
        _cancelToken = cancelToken;

  Future<List<ShowModel>> fetchAll({
    JSON? queryParameters,
  }) async {
    return await _apiService.getCollectionData<ShowModel>(
      endpoint: ApiEndpoint.shows(
          queryParameters != null ? ShowEndpoint.FILTERS : ShowEndpoint.BASE
      ),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => ShowModel.fromJson(responseBody),
    );
  }

  Future<ShowModel> fetchOne({
    required int showId,
  }) async {
    return await _apiService.getDocumentData<ShowModel>(
      endpoint: ApiEndpoint.shows(ShowEndpoint.BY_ID, id: showId),
      cancelToken: _cancelToken,
      converter: (responseBody) => ShowModel.fromJson(responseBody),
    );
  }

  Future<int> create({
    required JSON data,
  }) async {
    return await _apiService.setData<int>(
      endpoint: ApiEndpoint.shows(ShowEndpoint.BASE),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['body']['show_id'] as int,
    );
  }

  Future<String> update({
    required int showId,
    required JSON data,
  }) async {
    return await _apiService.updateData<String>(
      endpoint: ApiEndpoint.shows(ShowEndpoint.BY_ID, id: showId),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  Future<String> delete({
    required int showId,
    JSON? data,
  }) async {
    return await _apiService.deleteData<String>(
      endpoint: ApiEndpoint.shows(ShowEndpoint.BY_ID, id: showId),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  void cancelRequests() {
    _apiService.cancelRequests(cancelToken: _cancelToken);
  }
}
