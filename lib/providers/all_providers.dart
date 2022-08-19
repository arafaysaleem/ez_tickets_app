import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Service imports
import '../services/local_storage/key_value_storage_service.dart';
import '../services/networking/api_endpoint.dart';
import '../services/networking/api_service.dart';
import '../services/networking/dio_service.dart';
//Interceptor imports
import '../services/networking/interceptors/api_interceptor.dart';
import '../services/networking/interceptors/logging_interceptor.dart';
import '../services/networking/interceptors/refresh_token_interceptor.dart';
//Repository imports
import '../services/repositories/auth_repository.dart';
import '../services/repositories/bookings_repository.dart';
import '../services/repositories/movies_repository.dart';
import '../services/repositories/payments_repository.dart';
import '../services/repositories/shows_repository.dart';
import '../services/repositories/theaters_repository.dart';
//Provider imports
import 'auth_provider.dart';
import 'bookings_provider.dart';
import 'forgot_password_provider.dart';
import 'movies_provider.dart';
import 'payments_provider.dart';
import 'shows_provider.dart';
//State imports
import 'states/auth_state.dart';
import 'states/forgot_password_state.dart';
import 'theaters_provider.dart';

//Services
final keyValueStorageServiceProvider = Provider<KeyValueStorageService>(
  (ref) => KeyValueStorageService(),
);

final _dioProvider = Provider<Dio>((ref) {
  final baseOptions = BaseOptions(
    baseUrl: ApiEndpoint.baseUrl,
  );
  return Dio(baseOptions);
});

final _dioServiceProvider = Provider<DioService>((ref) {
  final dio = ref.watch(_dioProvider);
  // Order of interceptors very important
  return DioService(
    dioClient: dio,
    interceptors: [
      ApiInterceptor(ref),
      if (kDebugMode) LoggingInterceptor(),
      RefreshTokenInterceptor(dioClient: dio, ref: ref)
    ],
  );
});

final _apiServiceProvider = Provider<ApiService>((ref) {
  final dioService = ref.watch(_dioServiceProvider);
  return ApiService(dioService);
});

//repositories providers
final _authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiService = ref.watch(_apiServiceProvider);
  return AuthRepository(apiService: apiService);
});

final _moviesRepositoryProvider = Provider<MoviesRepository>((ref) {
  final apiService = ref.watch(_apiServiceProvider);
  return MoviesRepository(apiService: apiService);
});

final _showsRepositoryProvider = Provider<ShowsRepository>((ref) {
  final apiService = ref.watch(_apiServiceProvider);
  return ShowsRepository(apiService: apiService);
});

final _theatersRepositoryProvider = Provider<TheatersRepository>((ref) {
  final apiService = ref.watch(_apiServiceProvider);
  return TheatersRepository(apiService: apiService);
});

final _bookingsRepositoryProvider = Provider<BookingsRepository>((ref) {
  final apiService = ref.watch(_apiServiceProvider);
  return BookingsRepository(apiService: apiService);
});

final _paymentsRepositoryProvider = Provider<PaymentsRepository>((ref) {
  final apiService = ref.watch(_apiServiceProvider);
  return PaymentsRepository(apiService: apiService);
});

//notifier providers
final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  final authRepository = ref.watch(_authRepositoryProvider);
  final keyValueStorageService = ref.watch(keyValueStorageServiceProvider);
  return AuthProvider(
    ref: ref,
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService,
  );
});

final forgotPasswordProvider = StateNotifierProvider.autoDispose<
    ForgotPasswordProvider, ForgotPasswordState>((ref) {
  final authRepository = ref.watch(_authRepositoryProvider);
  return ForgotPasswordProvider(
    authRepository: authRepository,
    initialState: const ForgotPasswordState.email(),
  );
});

//data providers
final moviesProvider = Provider<MoviesProvider>((ref) {
  final moviesRepository = ref.watch(_moviesRepositoryProvider);
  return MoviesProvider(moviesRepository);
});

final showsProvider = Provider<ShowsProvider>((ref) {
  final showsRepository = ref.watch(_showsRepositoryProvider);
  return ShowsProvider(showsRepository);
});

final theatersProvider = ChangeNotifierProvider<TheatersProvider>((ref) {
  final theatersRepository = ref.watch(_theatersRepositoryProvider);
  return TheatersProvider(theatersRepository);
});

final bookingsProvider = Provider<BookingsProvider>((ref) {
  final bookingsRepository = ref.watch(_bookingsRepositoryProvider);
  return BookingsProvider(
    ref: ref,
    bookingsRepository: bookingsRepository,
  );
});

final paymentsProvider = Provider<PaymentsProvider>((ref) {
  final paymentsRepository = ref.watch(_paymentsRepositoryProvider);
  return PaymentsProvider(
    ref: ref,
    paymentsRepository: paymentsRepository,
  );
});
