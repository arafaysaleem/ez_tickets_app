import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Providers
import 'package:ez_ticketz_app/providers/all_providers.dart';
import 'common_mocked_providers.dart';

//Screens
import 'package:ez_ticketz_app/views/screens/register_screen.dart';
import 'package:ez_ticketz_app/views/widgets/common/custom_text_button.dart';
import 'package:ez_ticketz_app/views/widgets/common/custom_textfield.dart';

//Config
import '../flutter_test_config.dart';

void main() {
  group('RegisterScreen', () {
    late Widget registerScreen;

    setUp((){
      registerScreen = ProviderScope(
        overrides: [
          authProvider.overrideWithProvider(mockAuthProvider),
        ],
        child: const RegisterScreen(),
      );
    });

    testGoldens(
      'GIVEN the register button is pressed '
      'WHEN the register screen is shown '
      'THEN it looks like register_screen_golden.png',
      (tester) async {
        //when
        await tester.pumpWidgetBuilder(
          registerScreen,
          surfaceSize: GoldensGlobalConfig.defaultSurfaceSize,
          wrapper: GoldensGlobalConfig.globalAppWrapper,
        );

        //then
        await screenMatchesGolden(tester, 'register_screen_golden');
      },
    );

    testGoldens(
      'GIVEN we are on register screen '
      'AND the user details are filled '
      'WHEN Next button is pressed '
      'AND the screen is rebuilt '
      'THEN it looks like register_screen_2_golden.png',
      (tester) async {
        //given
        await tester.pumpWidgetBuilder(
          registerScreen,
          surfaceSize: GoldensGlobalConfig.defaultSurfaceSize,
          wrapper: GoldensGlobalConfig.globalAppWrapper,
        );

        //and fill the fullName field
        final fullNameField = find.widgetWithText(CustomTextField, 'Full name');
        await tester.pumpAndSettle();
        await tester.enterText(fullNameField, 'Test User');

        //and fill the email field
        final emailField = find.widgetWithText(CustomTextField, 'Email');
        await tester.enterText(emailField, 'test.user@gmail.com');

        //and fill the address field
        final addressField = find.widgetWithText(CustomTextField, 'Address');
        await tester.enterText(addressField, '123-E Street');

        //and fill the contact field
        final contactField = find.widgetWithText(CustomTextField, 'Contact');
        await tester.enterText(contactField, '3001234567');

        //and dismiss keyboard
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();

        //when
        //find a CustomTextButton having descendant Text('Next')
        final nextButton = find.ancestor(
          of: find.text('Next'),
          matching: find.byWidgetPredicate(
            (widget) => widget is CustomTextButton,
          ),
        );

        //tap button next
        await tester.tap(nextButton);

        //rebuild screen
        await tester.pump();

        //then
        await screenMatchesGolden(tester, 'register_screen_2_golden');
      },
    );
  });
}
