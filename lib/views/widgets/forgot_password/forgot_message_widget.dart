import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../helper/extensions/context_extensions.dart';
import '../../../helper/utils/constants.dart';

//Providers
import '../../../../providers/auth_provider.dart';


class ForgotMessageWidget extends HookWidget {
  const ForgotMessageWidget({
    Key? key,
  }) : super(key: key);

  Text _buildMessageText(BuildContext ctx, String message) {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: ctx.bodyText1.copyWith(
        color: Constants.textGreyColor,
        fontSize: 17,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _forgotPasswordState = useProvider(forgotPasswordStateProvider).state;
    return _forgotPasswordState.when(
      email: () => _buildMessageText(
        context,
        'A 4 digit OTP will be sent to this email once verified',
      ),
      otp: (message) => _buildMessageText(context, message),
      resetPassword: (message) => _buildMessageText(context, message),
      loading: (message) => _buildMessageText(context, message),
      failed: (message) => _buildMessageText(context, message),
      success: (_) => const SizedBox.shrink(),
    );
  }
}
