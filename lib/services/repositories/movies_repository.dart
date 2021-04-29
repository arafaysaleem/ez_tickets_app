//models
import '../../models/movie_role_model.dart';
import '../../models/movie_model.dart';

//services
import '../networking/api_endpoint.dart';
import '../networking/api_service.dart';

class MoviesRepository {
  final ApiService _apiService;

  MoviesRepository({required ApiService apiService}) : _apiService = apiService;

  /// In the builder we:
  /// 1. Add the newly added movie's id
  /// 2. Removes roles info
  /// 3. Parse into Movie Model
  Future<MovieModel> addAMovie({
    required Map<String, dynamic> data,
  }) async {
    return await _apiService.setData<MovieModel>(
      endpoint: ApiEndpoint.movies(),
      data: data,
      builder: (response) {
        data["movie_id"] = response["body"]["movie_id"];
        data.remove("roles");
        return MovieModel.fromJson(data);
      },
    );
  }

  Future<bool> updateAMovie({
    required int movieId,
    required Map<String, dynamic> data,
  }) async {
    return await _apiService.updateData<bool>(
      endpoint: ApiEndpoint.movies(id: movieId),
      data: data,
      requiresAuthToken: true,
      builder: (response) => response["headers"]["success"] == 1,
    );
  }

  Future<bool> deleteAMovie({
    required int movieId,
    Map<String, dynamic>? data,
  }) async {
    return await _apiService.deleteData<bool>(
      endpoint: ApiEndpoint.movies(id: movieId),
      data: data,
      builder: (response) => response["headers"]["success"] == 1,
    );
  }

  Future<List<MovieModel>> fetchAllMovies({
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _apiService.getCollectionData<MovieModel>(
      endpoint: ApiEndpoint.movies(),
      queryParams: queryParameters,
      builder: (response) => MovieModel.fromJson(response),
    );
  }

  Future<MovieModel> fetchSingleMovie({
    required int movieId,
  }) async {
    return await _apiService.getDocumentData<MovieModel>(
      endpoint: ApiEndpoint.movies(id: movieId),
      builder: (response) => MovieModel.fromJson(response),
    );
  }

  /// Response is of type:
  /// {
  ///   role_id: 1,
  ///   full_name: ...,
  ///   ...,
  ///   role_type: "director"
  /// }
  ///
  /// In the builder we:
  /// 1. Separate the role type
  /// 2. Make new map with role key having response map and
  ///    role_type key having roleType String.
  /// 3. Parse it into MovieRoleModel
  ///
  /// TODO: Improve response type in API to contain role as Map
  Future<List<MovieRoleModel>> fetchMovieRoles({
    required int movieId,
  }) async {
    return await _apiService.getCollectionData<MovieRoleModel>(
      endpoint: ApiEndpoint.movies(id: movieId, searchRoles: true),
      builder: (response) {
        final String roleType = response["role_type"];
        response.remove("role_type");
        final Map<String,dynamic> movieRole = {
          "role": response,
          "role_type" : roleType,
        };
        return MovieRoleModel.fromJson(movieRole);
      },
    );
  }
}
