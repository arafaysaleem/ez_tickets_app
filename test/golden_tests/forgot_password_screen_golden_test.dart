import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Providers
import 'package:ez_ticketz_app/providers/all_providers.dart';
import 'package:ez_ticketz_app/providers/forgot_password_provider.dart';
import 'package:ez_ticketz_app/providers/states/forgot_password_state.dart';
import 'common_mocked_providers.dart';

//Screens
import 'package:ez_ticketz_app/views/screens/forgot_password_screen.dart';

//Config
import '../flutter_test_config.dart';

void main() {
  group(
    'ForgotPasswordScreen',
    () {
      const forgotPasswordScreen = ForgotPasswordScreen();

      testGoldens(
        'GIVEN the forgot password link is pressed '
        'WHEN the forgot password screen is shown '
        'THEN it looks like forgot_password_screen_email_golden.png',
        (tester) async {
          //when
          await tester.pumpWidgetBuilder(
            const ProviderScope(
              child: forgotPasswordScreen,
            ),
            surfaceSize: GoldensGlobalConfig.defaultSurfaceSize,
            wrapper: GoldensGlobalConfig.globalAppWrapper,
          );

          //then
          await screenMatchesGolden(
            tester,
            'forgot_password_screen_email_golden',
          );
        },
      );

      testGoldens(
        'GIVEN we are on forgot password screen '
        'AND the otp has been sent '
        'WHEN the screen is rebuilt '
        'AND OTP screen opens '
        'THEN it looks like forgot_password_screen_otp_golden.png',
        (tester) async {
          //given
          await tester.pumpWidgetBuilder(
            ProviderScope(
              overrides: [
                forgotPasswordProvider.overrideWithValue(
                  ForgotPasswordProvider(
                    authRepository: MockAuthRepository(),
                    initialState: const ForgotPasswordState.otp(
                      otpSentMessage: 'otpSentMessage',
                    ),
                  ),
                )
              ],
              child: forgotPasswordScreen,
            ),
            surfaceSize: GoldensGlobalConfig.defaultSurfaceSize,
            wrapper: GoldensGlobalConfig.globalAppWrapper,
          );

          //rebuild screen
          await tester.pump();

          //then
          await screenMatchesGolden(
            tester,
            'forgot_password_screen_otp_golden',
          );
        },
      );

      testGoldens(
        'GIVEN we are on forgot password screen '
        'AND the otp has been verified '
        'WHEN the screen is rebuilt '
        'AND the reset password screen is opened '
        'THEN it looks like forgot_password_screen_resetPw_golden.png',
        (tester) async {
          //given
          await tester.pumpWidgetBuilder(
            ProviderScope(
              overrides: [
                forgotPasswordProvider.overrideWithValue(
                  ForgotPasswordProvider(
                    authRepository: MockAuthRepository(),
                    initialState: const ForgotPasswordState.resetPassword(
                      otpVerifiedMessage: 'otpVerifiedMessage',
                    ),
                  ),
                )
              ],
              child: forgotPasswordScreen,
            ),
            surfaceSize: GoldensGlobalConfig.defaultSurfaceSize,
            wrapper: GoldensGlobalConfig.globalAppWrapper,
          );

          //rebuild screen
          await tester.pump();

          //then
          await screenMatchesGolden(
            tester,
            'forgot_password_screen_resetPw_golden',
          );
        },
      );
    },
  );
}
