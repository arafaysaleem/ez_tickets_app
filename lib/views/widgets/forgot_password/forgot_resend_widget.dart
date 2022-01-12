import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Providers
import '../../../providers/all_providers.dart';

//Helpers
import '../../../helper/extensions/context_extensions.dart';
import '../../../helper/utils/constants.dart';

class ForgotResendWidget extends HookConsumerWidget {
  const ForgotResendWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _forgotPasswordState = ref.watch(forgotPasswordProvider);
    return _forgotPasswordState.maybeWhen(
      otp: (_) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              ref.read(forgotPasswordProvider.notifier).resendOtpCode();
            },
            child: Text(
              'Resend OTP',
              style: context.headline3.copyWith(
                fontSize: 17,
                color: Constants.primaryColor
              ),
            ),
          ),
        ],
      ),
      orElse: () => const SizedBox.shrink(),
    );
  }
}
