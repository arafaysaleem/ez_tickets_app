import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../helper/extensions/context_extensions.dart';
import '../../../helper/utils/constants.dart';

//Providers
import '../../../providers/all_providers.dart';

class ForgotMessageWidget extends HookConsumerWidget {
  const ForgotMessageWidget({
    Key? key,
  }) : super(key: key);

  Text _buildMessageText(BuildContext ctx, String message) {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: ctx.bodyText1.copyWith(
        color: Constants.textGreyColor,
        fontSize: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _forgotPasswordState = ref.watch(forgotPasswordProvider);
    return _forgotPasswordState.maybeWhen(
      email: () => _buildMessageText(
        context,
        'A 4 digit OTP will be sent to this email once verified',
      ),
      otp: (message) => _buildMessageText(context, message),
      resetPassword: (message) => _buildMessageText(context, message),
      loading: (message) => _buildMessageText(context, message),
      orElse: () => const SizedBox.shrink(),
    );
  }
}
