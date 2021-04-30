//Services
import '../services/repositories/movies_repository.dart';

//Enums
import '../enums/movie_type_enum.dart';

//Models
import '../models/movie_model.dart';
import '../models/movie_role_model.dart';

class MoviesProvider {
  final MoviesRepository _moviesRepository;

  MoviesProvider(this._moviesRepository);

  Future<List<MovieModel>> getAllMovies({
    MovieType? movieType,
  }) async {
    final Map<String, String>? queryParams = {
      if (movieType != null) "movie_type": movieType.toJson,
    };
    return await _moviesRepository.fetchAll(queryParameters: queryParams);
  }

  Future<MovieModel> getMovieById({
    required int movieId,
  }) async {
    return await _moviesRepository.fetchOne(movieId: movieId);
  }

  Future<List<MovieRoleModel>> getMovieRoles({
    required int movieId,
  }) async {
    return await _moviesRepository.fetchMovieRoles(movieId: movieId);
  }

  Future<MovieModel> uploadNewMovie({
    required String title,
    required int year,
    required String summary,
    required String trailerUrl,
    required String posterUrl,
    required double rating,
    required MovieType movieType,
    required List<MovieRoleModel> movieRoles,
  }) async {
    final movie = MovieModel(
      movieId: -1,
      title: title,
      year: year,
      summary: summary,
      trailerUrl: trailerUrl,
      posterUrl: posterUrl,
      rating: rating,
      movieType: movieType,
    );
    final roles =
        movieRoles.map((movieRole) => movieRole.toCustomJson()).toList();
    final Map<String, dynamic> data = {
      ...movie.toJson(),
      "roles": roles,
    };
    final movieId = await _moviesRepository.create(data: data);
    return movie.copyWith(movieId: movieId);
  }

  Future<String> editMovie({
    required int movieId,
    String? title,
    String? year,
    String? summary,
    String? trailerUrl,
    String? posterUrl,
    double? rating,
    MovieType? movieType,
  }) async {
    final Map<String, dynamic> data = {
      if (title != null) "title": title,
      if (year != null) "year": year,
      if (summary != null) "summary": summary,
      if (trailerUrl != null) "trailer_url": trailerUrl,
      if (posterUrl != null) "poster_url": posterUrl,
      if (rating != null) "rating": rating,
      if (movieType != null) "movie_type": movieType.toJson,
    };
    if (data.isEmpty) return "Nothing to update!";
    return await _moviesRepository.update(movieId: movieId, data: data);
  }

  Future<String> removeMovie({
    required int movieId,
  }) async {
    return await _moviesRepository.delete(movieId: movieId);
  }
}
