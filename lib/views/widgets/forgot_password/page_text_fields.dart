import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../helper/utils/form_validator.dart';

//Providers
import '../../../providers/auth_provider.dart';

//Widgets
import '../common/custom_textfield.dart';
import 'reset_password_fields.dart';
import 'otp_code_fields.dart';

class PageTextFields extends StatefulHookWidget {
  const PageTextFields({
    Key? key,
    required this.emailController,
    required this.newPasswordController,
    required this.cNewPasswordController,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController newPasswordController;
  final TextEditingController cNewPasswordController;

  @override
  _ForgotPasswordFieldsState createState() => _ForgotPasswordFieldsState();
}

class _ForgotPasswordFieldsState extends State<PageTextFields> {
  late Widget currentTextFields;

  @override
  Widget build(BuildContext context) {
    final _forgotPasswordState = useProvider(forgotPasswordStateProvider).state;
    return _forgotPasswordState.maybeWhen(
      email: () {
        currentTextFields = CustomTextField(
          controller: widget.emailController,
          floatingText: 'Email',
          hintText: 'Type your email address',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: FormValidator.emailValidator,
        );
        return currentTextFields;
      },
      otp: (_) {
        currentTextFields = const OtpCodeFields();
        return currentTextFields;
      },
      resetPassword: (_) {
        currentTextFields = ResetPasswordFields(
          newPasswordController: widget.newPasswordController,
          cNewPasswordController: widget.cNewPasswordController,
        );
        return currentTextFields;
      },
      success: (_) => const SizedBox.shrink(),
      orElse: () => currentTextFields,
    );
  }
}
