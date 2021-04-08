import 'package:hooks_riverpod/hooks_riverpod.dart';

//services imports
import '../services/networking/api_service.dart';

//repository imports
import '../services/repositories/auth_repository.dart';

//provider imports
import 'auth_provider.dart';

//service providers
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

//repositories providers
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return AuthRepository(apiService: apiService);
});

//notifier providers
final authProvider = Provider<AuthProvider>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return AuthProvider(authRepository);
});
