import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../helper/utils/form_validator.dart';

//Widgets
import '../common/custom_textfield.dart';

final otpCodeProvider = StateProvider.autoDispose((ref) => ['0','0','0','0']);

class OtpCodeFields extends StatelessWidget {
  const OtpCodeFields({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //Digit 1-4
          for (int i = 0; i < 3; i++)
            CustomTextField(
              maxLength: 1,
              height: 55,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              validator: FormValidator.otpDigitValidator,
              onSaved: (digit) {
                context.read(otpCodeProvider).state[i] = digit!;
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
      ),
    );
  }
}
