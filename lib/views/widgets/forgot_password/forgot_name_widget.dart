import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../helper/extensions/context_extensions.dart';

//Providers
import '../../../providers/all_providers.dart';

class ForgotNameWidget extends StatefulHookWidget {
  const ForgotNameWidget({
    Key? key,
  }) : super(key: key);

  @override
  _PageNameWidgetState createState() => _PageNameWidgetState();
}

class _PageNameWidgetState extends State<ForgotNameWidget> {
  late Text currentPageText;

  Text _buildText(String pageName) {
    return Text(
      pageName,
      style: context.headline3.copyWith(fontSize: 22),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _forgotPasswordState = useProvider(forgotPasswordProvider);
    return _forgotPasswordState.maybeWhen(
      email: () {
        currentPageText = _buildText('Forgot Password');
        return currentPageText;
      },
      otp: (_) {
        currentPageText = _buildText('Verify Otp');
        return currentPageText;
      },
      resetPassword: (_) {
        currentPageText = _buildText('Reset Password');
        return currentPageText;
      },
      success: (_) => const SizedBox.shrink(),
      orElse: () => currentPageText,
    );
  }
}
