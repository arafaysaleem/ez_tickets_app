import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Providers
import 'package:ez_ticketz_app/providers/all_providers.dart';
import 'common_mocked_providers.dart';

//Screens
import 'package:ez_ticketz_app/views/screens/change_password_screen.dart';

//Config
import '../flutter_test_config.dart';

void main() {
  group('ChangePasswordScreen', () {
    testGoldens(
      'GIVEN the change password icon is pressed '
      'WHEN the change password screen is shown '
      'THEN it looks like change_password_screen_golden.png',
      (tester) async {
        //when
        await tester.pumpWidgetBuilder(
          ProviderScope(
            overrides: [
              authProvider.overrideWithProvider(mockAuthProvider)
            ],
            child: const ChangePasswordScreen(),
          ),
          surfaceSize: GoldensGlobalConfig.defaultSurfaceSize,
          wrapper: GoldensGlobalConfig.globalAppWrapper,
        );

        //then
        await screenMatchesGolden(tester, 'change_password_screen_golden');
      },
    );
  });
}
