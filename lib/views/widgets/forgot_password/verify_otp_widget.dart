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

class VerifyOtpWidget extends HookWidget {
  final String email, otpSentMessage;

  const VerifyOtpWidget({
    Key? key,
    required this.email,
    required this.otpSentMessage,
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
                'Verify Otp',
                textAlign: TextAlign.center,
                style: context.headline3.copyWith(fontSize: 22),
              ),

              const SizedBox(height: 20),

              //otp fields
              SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //Digit 1-4
                    for (int i = 0; i < 3; i++) ...[
                      CustomTextField(
                        maxLength: 1,
                        height: 55,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        validator: FormValidator.otpDigitValidator,
                        onSaved: (digit) => _OTPCode.setDigit(digit, i),
                        onChanged: (digit) {
                          if (digit!.length == 1) {
                            FocusScope.of(context).nextFocus();
                          } else if (digit.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                      )
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 10),

              //Email otp message
              Text(
                otpSentMessage,
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
        GestureDetector(
          onTap: () {},
          child: const Text(
            'Resend OTP',
            style: TextStyle(
              fontSize: 17,
              color: Constants.primaryColor,
            ),
          ),
        ),

        const Spacer(),

        //Verify Otp Button
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, Constants.bottomInsets),
          child: CustomTextButton.gradient(
            width: double.infinity,
            gradient: Constants.buttonGradientOrange,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                final _authProv = context.read(authProvider.notifier);
                _authProv.verifyOtp(email: email, otp: _OTPCode.otpCode);
              }
            },
            child: Center(
              child: Consumer(
                builder: (_, watch, child) => watch(
                    forgotPasswordStateProvider,
                  ).state.maybeWhen(
                    loading: (_) => const SpinKitRing(
                      color: Colors.white,
                      size: 30,
                      lineWidth: 4,
                      duration: Duration(milliseconds: 1100),
                    ),
                    orElse: () => child!,
                  ),
                child: const Text(
                  'VERIFY OTP',
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

class _OTPCode {
  static const List<String> _otpDigits = ['0', '0', '0', '0'];

  static void setDigit(String? digit, int i) => _otpDigits[i] = digit!;

  static String get otpCode =>
      _otpDigits.fold('', (otp, digit) => '$otp$digit');
}
