import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

//Screens
import 'package:ez_ticketz_app/views/screens/home_screen.dart';

//Config
import '../flutter_test_config.dart';

void main() {
  group('HomeScreen', () {
    testGoldens(
      'GIVEN the app is started '
      'WHEN the home screen is shown '
      'THEN it looks like home_screen_golden.png',
      (tester) async {
        await tester.pumpWidgetBuilder(
          const HomeScreen(),
          surfaceSize: GoldensGlobalConfig.defaultSurfaceSize,
          wrapper: GoldensGlobalConfig.globalAppWrapper,
        );
        await screenMatchesGolden(tester, 'home_screen_golden');
      },
    );
  });
}
