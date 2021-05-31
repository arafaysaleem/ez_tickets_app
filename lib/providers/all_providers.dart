import 'package:hooks_riverpod/hooks_riverpod.dart';

//services imports
import '../services/local_storage/prefs_service.dart';
import '../services/networking/api_service.dart';

//repository imports
import '../services/repositories/auth_repository.dart';
import '../services/repositories/movies_repository.dart';
import '../services/repositories/shows_repository.dart';
import '../services/repositories/theaters_repository.dart';

//provider imports
import 'auth_provider.dart';
import 'movies_provider.dart';
import 'shows_provider.dart';
import 'theaters_provider.dart';

//states
import 'states/auth_state.dart';

//service providers
final _apiServiceProvider = Provider<ApiService>((ref) => ApiService());
final _prefsServiceProvider = Provider<PrefsService>((ref) => PrefsService());

//repositories providers
final _authRepositoryProvider = Provider<AuthRepository>((ref) {
  final _apiService = ref.watch(_apiServiceProvider);
  return AuthRepository(apiService: _apiService);
});

final _moviesRepositoryProvider = Provider<MoviesRepository>((ref) {
  final _apiService = ref.watch(_apiServiceProvider);
  return MoviesRepository(apiService: _apiService);
});

final _showsRepositoryProvider = Provider<ShowsRepository>((ref) {
  final _apiService = ref.watch(_apiServiceProvider);
  return ShowsRepository(apiService: _apiService);
});

final _theatersRepositoryProvider = Provider<TheatersRepository>((ref){
  final _apiService = ref.watch(_apiServiceProvider);
  return TheatersRepository(apiService: _apiService);
});

//notifier providers
final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  final _authRepository = ref.watch(_authRepositoryProvider);
  final _prefsService = ref.watch(_prefsServiceProvider);
  return AuthProvider(_authRepository, _prefsService);
});

//data providers
final moviesProvider = Provider<MoviesProvider>((ref) {
  final _moviesRepository = ref.watch(_moviesRepositoryProvider);
  return MoviesProvider(_moviesRepository);
});

final showsProvider = Provider<ShowsProvider>((ref) {
  final _showsRepository = ref.watch(_showsRepositoryProvider);
  return ShowsProvider(_showsRepository);
});

final theatersProvider = Provider<TheatersProvider>((ref){
  final _theatersRepository = ref.watch(_theatersRepositoryProvider);
  return TheatersProvider(_theatersRepository);
});
