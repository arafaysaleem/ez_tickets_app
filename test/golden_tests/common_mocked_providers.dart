import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';

//Models
import 'package:ez_ticketz_app/models/user_model.dart';

//Providers
import 'package:ez_ticketz_app/providers/auth_provider.dart';

//States
import 'package:ez_ticketz_app/providers/states/auth_state.dart';

//Services
import 'package:ez_ticketz_app/services/local_storage/key_value_storage_service.dart';
import 'package:ez_ticketz_app/services/repositories/auth_repository.dart';

//Mocks
class _MockKVStorageService extends Mock implements KeyValueStorageService {
  @override
  bool getAuthState() => false;

  @override
  UserModel? getAuthUser() => null;

  @override
  Future<String> getAuthPassword() => SynchronousFuture('');

  @override
  void resetKeys() {}
}

//Fakes
class MockAuthRepository extends Fake implements AuthRepository {}

//Providers
final mockAuthProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  return AuthProvider(
    ref: ref,
    authRepository: MockAuthRepository(),
    keyValueStorageService: _MockKVStorageService(),
  );
});
