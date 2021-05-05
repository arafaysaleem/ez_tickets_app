import 'package:dio/dio.dart';

//models
import '../../models/movie_model.dart';
import '../../models/movie_role_model.dart';

//services
import '../networking/api_endpoint.dart';
import '../networking/api_service.dart';

class MoviesRepository {
  final ApiService _apiService;
  final CancelToken? _cancelToken;

  MoviesRepository({
    required ApiService apiService,
    CancelToken? cancelToken,
  })  : _apiService = apiService,
        _cancelToken = cancelToken;

  Future<int> create({
    required Map<String, dynamic> data,
  }) async {
    return await _apiService.setData<int>(
      endpoint: ApiEndpoint.movies(MovieEndpoint.BASE),
      data: data,
      cancelToken: _cancelToken,
      builder: (response) => response["body"]["movie_id"],
    );
  }

  Future<String> update({
    required int movieId,
    required Map<String, dynamic> data,
  }) async {
    return await _apiService.updateData<String>(
      endpoint: ApiEndpoint.movies(MovieEndpoint.BY_ID, id: movieId),
      data: data,
      cancelToken: _cancelToken,
      builder: (response) => response["headers"]["message"],
    );
  }

  Future<String> delete({
    required int movieId,
    Map<String, dynamic>? data,
  }) async {
    return await _apiService.deleteData<String>(
      endpoint: ApiEndpoint.movies(MovieEndpoint.BY_ID, id: movieId),
      data: data,
      cancelToken: _cancelToken,
      builder: (response) => response["headers"]["message"],
    );
  }

  Future<List<MovieModel>> fetchAll({
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _apiService.getCollectionData<MovieModel>(
      endpoint: ApiEndpoint.movies(MovieEndpoint.BASE),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      builder: (responseBody) => MovieModel.fromJson(responseBody),
    );
  }

  Future<MovieModel> fetchOne({
    required int movieId,
  }) async {
    return await _apiService.getDocumentData<MovieModel>(
      endpoint: ApiEndpoint.movies(MovieEndpoint.BY_ID, id: movieId),
      cancelToken: _cancelToken,
      builder: (responseBody) => MovieModel.fromJson(responseBody),
    );
  }

  Future<List<MovieRoleModel>> fetchMovieRoles({
    required int movieId,
  }) async {
    return await _apiService.getCollectionData<MovieRoleModel>(
      endpoint: ApiEndpoint.movies(MovieEndpoint.ROLES, id: movieId),
      cancelToken: _cancelToken,
      builder: (responseBody) => MovieRoleModel.fromJson(responseBody),
    );
  }

  void cancelRequests() {
    _apiService.cancelRequests(cancelToken: _cancelToken);
  }
}
