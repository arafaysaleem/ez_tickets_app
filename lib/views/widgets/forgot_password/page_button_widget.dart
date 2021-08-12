import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../helper/utils/constants.dart';

//Providers
import '../../../providers/all_providers.dart';
import '../../../providers/auth_provider.dart';

//Widgets
import '../common/custom_text_button.dart';
import 'otp_code_fields.dart' show otpCodeProvider;

class PageButtonWidget extends StatefulHookWidget {
  final String email;
  final String newPassword;
  final GlobalKey<FormState> formKey;

  const PageButtonWidget({
    Key? key,
    required this.email,
    required this.newPassword,
    required this.formKey,
  }) : super(key: key);

  @override
  _PageButtonWidgetState createState() => _PageButtonWidgetState();
}

class _PageButtonWidgetState extends State<PageButtonWidget> {
  late Widget currentPageButton;

  @override
  Widget build(BuildContext context) {
    final _forgotPasswordState = useProvider(forgotPasswordStateProvider).state;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, Constants.bottomInsets),
      child: _forgotPasswordState.when(
        email: () {
          currentPageButton = CustomTextButton.gradient(
            width: double.infinity,
            onPressed: () {
              if (widget.formKey.currentState!.validate()) {
                widget.formKey.currentState!.save();
                final _authProv = context.read(authProvider.notifier);
                _authProv.forgotPassword(widget.email);
              }
            },
            gradient: Constants.buttonGradientOrange,
            child: const Center(
              child: Text(
                'SEND OTP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  letterSpacing: 0.7,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
          return currentPageButton;
        },
        otp: (_) {
          currentPageButton = CustomTextButton.gradient(
            width: double.infinity,
            onPressed: () {
              if (widget.formKey.currentState!.validate()) {
                widget.formKey.currentState!.save();
                final String otpCode = context
                    .read(otpCodeProvider)
                    .state
                    .fold('', (otp, digit) => '$otp$digit');
                final _authProv = context.read(authProvider.notifier);
                _authProv.verifyOtp(email: widget.email, otp: otpCode);
              }
            },
            gradient: Constants.buttonGradientOrange,
            child: const Center(
              child: Text('VERIFY OTP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    letterSpacing: 0.7,
                    fontWeight: FontWeight.w600,
                  )),
            ),
          );
          return currentPageButton;
        },
        resetPassword: (_) {
          currentPageButton = CustomTextButton.gradient(
            width: double.infinity,
            onPressed: () {
              if (widget.formKey.currentState!.validate()) {
                widget.formKey.currentState!.save();
                final _authProv = context.read(authProvider.notifier);
                _authProv.resetPassword(
                  email: widget.email,
                  password: widget.newPassword,
                );
              }
            },
            gradient: Constants.buttonGradientOrange,
            child: const Center(
              child: Text(
                'RESET PASSWORD',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  letterSpacing: 0.7,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
          return currentPageButton;
        },
        loading: (_) => CustomTextButton.gradient(
          width: double.infinity,
          onPressed: () {},
          gradient: Constants.buttonGradientOrange,
          child: const Center(
            child: SpinKitRing(
              color: Colors.white,
              size: 30,
              lineWidth: 4,
              duration: Duration(milliseconds: 1100),
            ),
          ),
        ),
        failed: (_) => currentPageButton,
        success: (_) => const SizedBox.shrink(),
      ),
    );
  }
}
