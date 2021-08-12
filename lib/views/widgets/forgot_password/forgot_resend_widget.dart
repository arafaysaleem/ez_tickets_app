import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Providers
import '../../../providers/auth_provider.dart';

//Helpers
import '../../../helper/utils/constants.dart';

class ForgotResendWidget extends HookWidget {
  const ForgotResendWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _forgotPasswordState = useProvider(forgotPasswordStateProvider).state;
    return _forgotPasswordState.maybeWhen(
      otp: (_) => GestureDetector(
        onTap: () {},
        child: const Text(
          'Resend OTP',
          style: TextStyle(
            fontSize: 17,
            color: Constants.primaryColor,
          ),
        ),
      ),
      orElse: () => const SizedBox.shrink(),
    );
  }
}
