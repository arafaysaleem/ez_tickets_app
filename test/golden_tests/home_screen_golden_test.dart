import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

//Theme
import 'package:ez_ticketz_app/helper/utils/custom_theme.dart';

//Screens
import 'package:ez_ticketz_app/views/screens/home_screen.dart';

void main() {
  group('HomeScreen', () {
    testGoldens(
      'GIVEN the app is started '
      'WHEN the home screen is shown '
      'THEN it looks like home_screen_golden.png',
      (tester) async {
        await tester.pumpWidgetBuilder(
          const HomeScreen(),
          wrapper: materialAppWrapper(
            theme: CustomTheme.mainTheme,
          ),
        );
        await multiScreenGolden(tester, 'home_screen_golden');
      },
    );
  });
}
