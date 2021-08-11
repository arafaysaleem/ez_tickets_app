import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//Helpers
import '../../../helper/extensions/context_extensions.dart';
import '../../../helper/utils/constants.dart';
import '../../../helper/utils/form_validator.dart';

//Providers
import '../../../providers/all_providers.dart';
import '../../../providers/auth_provider.dart';

//Widgets
import '../common/custom_text_button.dart';
import '../common/custom_textfield.dart';
import '../common/rounded_bottom_container.dart';
import '../common/scrollable_column.dart';

class ResetPassWidget extends HookWidget {
  final String email, otpVerifiedMessage;

  const ResetPassWidget({
    Key? key,
    required this.email,
    required this.otpVerifiedMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newPasswordController = useTextEditingController();
    final cNewPasswordController = useTextEditingController();
    late final _formKey = useMemoized(() => GlobalKey<FormState>());
    return ScrollableColumn(
      children: [
        //Input card
        Form(
          key: _formKey,
          child: RoundedBottomContainer(
            children: [
              //Page name
              Text(
                'Reset Password',
                textAlign: TextAlign.center,
                style: context.headline3.copyWith(fontSize: 22),
              ),

              const SizedBox(height: 20),

              //New Password Field
              CustomTextField(
                hintText: 'Type your password',
                floatingText: 'New Password',
                controller: newPasswordController,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                validator: FormValidator.passwordValidator,
              ),

              const SizedBox(height: 25),

              //Confirm New Password Field
              CustomTextField(
                hintText: 'Retype your password',
                floatingText: 'New Password',
                controller: cNewPasswordController,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                validator: (confirmPw) => FormValidator.confirmPasswordValidator(
                  confirmPw,
                  newPasswordController.text,
                ),
              ),

              const SizedBox(height: 10),

              //Password reset message
              Text(
                otpVerifiedMessage,
                textAlign: TextAlign.center,
                style: context.bodyText1.copyWith(
                  color: Constants.textGreyColor,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 15),

        //Resend message
        const Text(
          "Upon success, you'll have to login again with your new password",
          style: TextStyle(
            fontSize: 17,
            color: Constants.primaryColor,
          ),
        ),

        const Spacer(),

        //Reset Password Button
        Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            40,
            20,
            Constants.bottomInsets,
          ),
          child: CustomTextButton.gradient(
            width: double.infinity,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                final _authProv = context.read(authProvider.notifier);
                _authProv.resetPassword(
                  email: email,
                  password: newPasswordController.text,
                );
              }
            },
            gradient: Constants.buttonGradientOrange,
            child: Center(
              child: Consumer(
                builder: (_, watch, child) {
                  final _forgotPasswordState =
                      watch(forgotPasswordStateProvider).state;
                  return _forgotPasswordState.maybeWhen(
                    loading: (_) => const SpinKitRing(
                      color: Colors.white,
                      size: 30,
                      lineWidth: 4,
                      duration: Duration(milliseconds: 1100),
                    ),
                    orElse: () => child!,
                  );
                },
                child: const Text(
                  'RESET PASSWORD',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    letterSpacing: 0.7,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
