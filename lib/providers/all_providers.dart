import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/movie_model.dart';
import '../services/local_storage/prefs_service.dart';

//services imports
import '../services/networking/api_service.dart';
import '../services/repositories/auth_repository.dart';

//repository imports
import '../services/repositories/movies_repository.dart';

//provider imports
import 'auth_provider.dart';
import 'movies_provider.dart';

//states
import 'states/auth_state.dart';

//service providers
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());
final prefsServiceProvider = Provider<PrefsService>((ref) => PrefsService());

//repositories providers
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final _apiService = ref.watch(apiServiceProvider);
  return AuthRepository(apiService: _apiService);
});

final moviesRepositoryProvider = Provider<MoviesRepository>((ref) {
  final _apiService = ref.watch(apiServiceProvider);
  return MoviesRepository(apiService: _apiService);
});

//notifier providers
final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  final _authRepository = ref.watch(authRepositoryProvider);
  final _prefsService = ref.watch(prefsServiceProvider);
  return AuthProvider(_authRepository, _prefsService);
});

//data providers
final moviesProvider = Provider<MoviesProvider>((ref) {
  final _moviesRepository = ref.watch(moviesRepositoryProvider);
  return MoviesProvider(_moviesRepository);
});

final selectedMovie = StateProvider<MovieModel>((ref) {
  return MovieModel.initial();
});
