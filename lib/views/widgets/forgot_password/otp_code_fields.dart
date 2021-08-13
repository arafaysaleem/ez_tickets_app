import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../helper/utils/form_validator.dart';

//Providers
import '../../../providers/all_providers.dart';

//Widgets
import '../common/custom_textfield.dart';

class OtpCodeFields extends StatelessWidget {
  const OtpCodeFields({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        //Digit 1-4
        for (int i = 0; i < 4; i++)
          CustomTextField(
            maxLength: 1,
            height: 55,
            width: 50,
            textAlign: TextAlign.center,
            errorTextAlign: Alignment.center,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            validator: FormValidator.otpDigitValidator,
            onSaved: (digit) {
              final forgotProv = context.read(forgotPasswordProvider.notifier);
              forgotProv.setOtpDigit(i, digit!);
            },
            onChanged: (digit) {
              if (digit!.length == 1) {
                FocusScope.of(context).nextFocus();
              } else if (digit.isEmpty) {
                FocusScope.of(context).previousFocus();
              }
            },
          ),
      ],
    );
  }
}
