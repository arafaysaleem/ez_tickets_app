import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../helper/extensions/context_extensions.dart';

//Providers
import '../../../providers/auth_provider.dart';

class ForgotNameWidget extends StatefulHookWidget {
  const ForgotNameWidget({
    Key? key,
  }) : super(key: key);

  @override
  _PageNameWidgetState createState() => _PageNameWidgetState();
}

class _PageNameWidgetState extends State<ForgotNameWidget> {
  late Text currentPageText;

  @override
  Widget build(BuildContext context) {
    final _forgotPasswordState = useProvider(forgotPasswordStateProvider).state;
    return _forgotPasswordState.maybeWhen(
      email: () {
        currentPageText = Text(
          'Forgot Password',
          textAlign: TextAlign.center,
          style: context.headline3.copyWith(fontSize: 22),
        );
        return currentPageText;
      },
      otp: (_) {
        currentPageText = Text(
          'Verify Otp',
          textAlign: TextAlign.center,
          style: context.headline3.copyWith(fontSize: 22),
        );
        return currentPageText;
      },
      resetPassword: (_) {
        currentPageText = Text(
          'Reset Password',
          textAlign: TextAlign.center,
          style: context.headline3.copyWith(fontSize: 22),
        );
        return currentPageText;
      },
      success: (_) => const SizedBox.shrink(),
      orElse: () => currentPageText,
    );
  }
}
