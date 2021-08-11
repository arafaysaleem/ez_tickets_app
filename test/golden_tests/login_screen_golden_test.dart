import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Providers
import 'package:ez_ticketz_app/providers/all_providers.dart';
import 'common_mocked_providers.dart';

//Screens
import 'package:ez_ticketz_app/views/screens/login_screen.dart';

//Config
import '../flutter_test_config.dart';

void main() {
  group('LoginScreen', () {
    testGoldens(
      'GIVEN the login button is pressed '
      'WHEN the login screen is shown '
      'THEN it looks like login_screen_golden.png',
      (tester) async {
        //when
        await tester.pumpWidgetBuilder(
          ProviderScope(
            overrides: [
              authProvider.overrideWithProvider(mockAuthProvider),
            ],
            child: const LoginScreen(),
          ),
          surfaceSize: GoldensGlobalConfig.defaultSurfaceSize,
          wrapper: GoldensGlobalConfig.globalAppWrapper,
        );

        //then
        await screenMatchesGolden(tester, 'login_screen_golden');
      },
    );
  });
}
