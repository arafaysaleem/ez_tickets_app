import 'package:flutter/material.dart';

//Helper
import '../../../helper/utils/form_validator.dart';

//Widget
import '../common/custom_textfield.dart';

class ResetPasswordFields extends StatelessWidget {
  final TextEditingController newPasswordController;
  final TextEditingController cNewPasswordController;

  const ResetPasswordFields({
    Key? key,
    required this.newPasswordController,
    required this.cNewPasswordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          floatingText: 'Confirm Password',
          controller: cNewPasswordController,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          validator: (confirmPw) => FormValidator.confirmPasswordValidator(
            confirmPw,
            newPasswordController.text,
          ),
        ),
      ],
    );
  }
}
