import 'package:ez_ticketz_app/helper/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Providers
import '../../../providers/all_providers.dart';

//Helpers
import '../../../helper/utils/constants.dart';

class ForgotResendWidget extends HookWidget {
  const ForgotResendWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _forgotPasswordState = useProvider(forgotPasswordProvider);
    return _forgotPasswordState.maybeWhen(
      otp: (_) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {},
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
