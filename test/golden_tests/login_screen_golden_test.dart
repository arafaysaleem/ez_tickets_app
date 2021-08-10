import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';

//Theme
import 'package:ez_ticketz_app/helper/utils/custom_theme.dart';

//Models
import 'package:ez_ticketz_app/models/user_model.dart';

//Providers
import 'package:ez_ticketz_app/providers/all_providers.dart';
import 'package:ez_ticketz_app/providers/auth_provider.dart';

//States
import 'package:ez_ticketz_app/providers/states/auth_state.dart';

//Services
import 'package:ez_ticketz_app/services/local_storage/key_value_storage_service.dart';
import 'package:ez_ticketz_app/services/repositories/auth_repository.dart';

//Screens
import 'package:ez_ticketz_app/views/screens/login_screen.dart';

class MockKVStorageService extends Mock implements KeyValueStorageService {
  @override
  bool getAuthState() => false;

  @override
  UserModel? getAuthUser() => null;

  @override
  Future<String> getAuthPassword() => SynchronousFuture('');

  @override
  void resetKeys() {}
}

class MockAuthRepository extends Fake implements AuthRepository {}

final _mockAuthProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  return AuthProvider(
    reader: ref.read,
    authRepository: MockAuthRepository(),
    keyValueStorageService: MockKVStorageService(),
  );
});

void main() {
  final _materialAppWrapper = materialAppWrapper(
    theme: CustomTheme.mainTheme,
  );

  group('LoginScreen', () {
    testGoldens(
      'GIVEN the login button is pressed '
      'WHEN the login screen is shown '
      'THEN it looks like login_screen_golden.png',
      (tester) async {
        await tester.pumpWidgetBuilder(
          ProviderScope(
            overrides: [
              authProvider.overrideWithProvider(_mockAuthProvider),
            ],
            child: const LoginScreen(),
          ),
          wrapper: _materialAppWrapper,
        );
        await multiScreenGolden(tester, 'login_screen_golden');
      },
    );
  });
}
