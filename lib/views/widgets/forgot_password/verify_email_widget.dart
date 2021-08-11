import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../helper/extensions/context_extensions.dart';
//Helpers
import '../../../helper/utils/constants.dart';
import '../../../helper/utils/form_validator.dart';
import '../../../providers/all_providers.dart';
//Providers
import '../../../providers/auth_provider.dart';
import '../common/custom_text_button.dart';
//Widgets
import '../common/custom_textfield.dart';
import '../common/rounded_bottom_container.dart';
import '../common/scrollable_column.dart';

class VerifyEmailWidget extends HookWidget {
  final TextEditingController emailController;

  const VerifyEmailWidget({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                'Forgot Password',
                textAlign: TextAlign.center,
                style: context.headline3.copyWith(fontSize: 22),
              ),

              const SizedBox(height: 20),

              //Email address field
              CustomTextField(
                controller: emailController,
                floatingText: 'Email',
                hintText: 'Type your email address',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: FormValidator.emailValidator,
              ),

              const SizedBox(height: 10),

              //Email otp message
              Text(
                'A 4 digit OTP will be sent to this email once verified',
                textAlign: TextAlign.center,
                style: context.bodyText1.copyWith(
                  color: Constants.textGreyColor,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),

        const Spacer(),

        //Forgot Password Button
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
                _authProv.forgotPassword(emailController.text);
              }
            },
            gradient: Constants.buttonGradientOrange,
            child: Center(
              child: Consumer(
                builder: (_, watch, child) {
                  final _forgotPasswordState = watch(forgotPasswordStateProvider).state;
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
                  'SEND OTP',
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
