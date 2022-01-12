import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../helper/utils/constants.dart';
import '../../../helper/utils/form_validator.dart';

//Providers
import '../../../providers/all_providers.dart';

//Widgets
import '../common/custom_textfield.dart';

class OtpCodeFields extends ConsumerWidget {
  const OtpCodeFields({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //Digit 1-4
            for (int i = 0; i < 4; i++)
              CustomTextField(
                maxLength: 1,
                width: 60,
                height: 60,
                contentPadding: const EdgeInsets.only(bottom: 10),
                inputStyle: const TextStyle(
                  fontSize: 35,
                  color: Constants.textWhite80Color,
                ),
                showErrorBorder: true,
                textAlign: TextAlign.center,
                errorAlign: Alignment.topCenter,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                validator: FormValidator.otpDigitValidator,
                onSaved: (digit) {
                  final forgotProv = ref.read(forgotPasswordProvider.notifier);
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
        ),
      ],
    );
  }
}
