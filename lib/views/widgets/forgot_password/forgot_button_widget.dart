import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../helper/utils/constants.dart';

//Providers
import '../../../providers/all_providers.dart';

//Widgets
import '../common/custom_text_button.dart';

class ForgotButtonWidget extends StatefulHookConsumerWidget {
  final TextEditingController emailController;
  final TextEditingController newPasswordController;
  final GlobalKey<FormState> formKey;

  const ForgotButtonWidget({
    Key? key,
    required this.emailController,
    required this.newPasswordController,
    required this.formKey,
  }) : super(key: key);

  @override
  _PageButtonWidgetState createState() => _PageButtonWidgetState();
}

class _PageButtonWidgetState extends ConsumerState<ForgotButtonWidget> {
  late Widget _currentPageButton;

  void _onPressed({
    bool isEmail = false,
    bool isOtp = false,
    bool isReset = false,
  }) {
    if (widget.formKey.currentState!.validate()) {
      widget.formKey.currentState!.save();
      final _forgotPasswordProv = ref.read(forgotPasswordProvider.notifier);
      if (isEmail) {
        _forgotPasswordProv.requestOtpCode(widget.emailController.text);
      } else if (isOtp) {
        _forgotPasswordProv.verifyOtp();
      } else if (isReset) {
        _forgotPasswordProv.resetPassword(
          password: widget.newPasswordController.text,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _forgotPasswordState = ref.watch(forgotPasswordProvider);
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
        failed: (_, __) => _currentPageButton,
        success: (_) => const SizedBox.shrink(),
      ),
    );
  }
}
