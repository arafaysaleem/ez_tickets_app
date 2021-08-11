import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../helper/utils/constants.dart';

//Providers
import '../../../providers/auth_provider.dart';
import '../../providers/states/forgot_password_state.dart';

//Widgets
import '../widgets/forgot_password/successful_reset_widget.dart';
import '../widgets/forgot_password/reset_password_widget.dart';
import '../widgets/forgot_password/verify_email_widget.dart';
import '../widgets/forgot_password/verify_otp_widget.dart';
import '../widgets/common/custom_dialog.dart';

class ForgotPasswordScreen extends HookWidget {
  const ForgotPasswordScreen();

  @override
  Widget build(BuildContext context) {
    final forgotPasswordState = useProvider(forgotPasswordStateProvider).state;
    final emailController = useTextEditingController();
    final child = VerifyEmailWidget(emailController: emailController);
    return Scaffold(
      body: ProviderListener<StateController<ForgotPasswordState>>(
        provider: forgotPasswordStateProvider,
        onChange: (context, forgotPasswordStateController) async =>
            forgotPasswordStateController.state.maybeWhen(
              success: (_) => emailController.clear(),
              failed: (reason) async => await showDialog<bool>(
                  context: context,
                  barrierColor: Constants.barrierColor.withOpacity(0.75),
                  builder: (ctx) => CustomDialog.alert(
                    title: 'Failure',
                    body: reason,
                    buttonText: 'Retry',
                  ),
                ),
              orElse: () {},
            ),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: forgotPasswordState.maybeWhen(
            email: () => child,
            otp: (otpSentMessage) => VerifyOtpWidget(
              email: emailController.text,
              otpSentMessage: otpSentMessage,
            ),
            resetPassword: (otpVerifiedMessage) => ResetPassWidget(
              email: emailController.text,
              otpVerifiedMessage: otpVerifiedMessage,
            ),
            success: (message) => SuccessfulResetWidget(successMessage: message),
            orElse: () => child,
          ),
        ),
      ),
    );
  }
}
