import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../helper/utils/constants.dart';

//Providers
import '../../../providers/all_providers.dart';
import '../../../providers/auth_provider.dart';
import 'otp_code_fields.dart' show otpCodeProvider;

//Widgets
import '../common/custom_text_button.dart';

class ForgotButtonWidget extends StatefulHookWidget {
  final String email;
  final String newPassword;
  final GlobalKey<FormState> formKey;

  const ForgotButtonWidget({
    Key? key,
    required this.email,
    required this.newPassword,
    required this.formKey,
  }) : super(key: key);

  @override
  _PageButtonWidgetState createState() => _PageButtonWidgetState();
}

class _PageButtonWidgetState extends State<ForgotButtonWidget> {
  late Widget _currentPageButton;

  void _onPressed({
    bool isEmail = false,
    bool isOtp = false,
    bool isReset = false,
  }) {
    if (widget.formKey.currentState!.validate()) {
      widget.formKey.currentState!.save();
      final _authProv = context.read(authProvider.notifier);
      if (isEmail) {
        _authProv.forgotPassword(widget.email);
      } else if (isOtp) {
        final String otpCode = context.read(otpCodeProvider).state.fold(
          '',
          (otp, digit) => '$otp$digit',
        );
        _authProv.verifyOtp(email: widget.email, otp: otpCode);
      } else if (isReset) {
        _authProv.resetPassword(
          email: widget.email,
          password: widget.newPassword,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _forgotPasswordState = useProvider(forgotPasswordStateProvider).state;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, Constants.bottomInsets),
      child: _forgotPasswordState.when(
        email: () {
          _currentPageButton = CustomTextButton.gradient(
            width: double.infinity,
            onPressed: () => _onPressed(isEmail: true),
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
          return _currentPageButton;
        },
        otp: (_) {
          _currentPageButton = CustomTextButton.gradient(
            width: double.infinity,
            onPressed: () => _onPressed(isOtp: true),
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
          return _currentPageButton;
        },
        resetPassword: (_) {
          _currentPageButton = CustomTextButton.gradient(
            width: double.infinity,
            onPressed: () => _onPressed(isReset: true),
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
          return _currentPageButton;
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
        failed: (_) => _currentPageButton,
        success: (_) => const SizedBox.shrink(),
      ),
    );
  }
}
