import 'package:flutter/material.dart';

//Helpers
import '../../../helper/utils/constants.dart';
import '../../../helper/extensions/context_extensions.dart';

//Widgets
import '../common/custom_textfield.dart';

class ChangePasswordFields extends StatelessWidget {
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController cNewPasswordController;

  const ChangePasswordFields({
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.cNewPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Current Password Label
        Text(
          "Current Password",
          style: context.bodyText1.copyWith(
              color: Constants.primaryColor,
              fontSize: 26,
              fontWeight: FontWeight.bold
          ),
        ),

        //Current Password Field
        CustomTextField(
          controller: currentPasswordController,
          hintText: "Enter current password",
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          validator: (cPassword) {
            if (newPasswordController.text.trim() == cPassword) return null;
            return "Passwords don't match";
          },
        ),

        const Spacer(),

        //New Password Label
        Text(
          "New Password",
          style: context.bodyText1.copyWith(
              color: Constants.primaryColor,
              fontSize: 26,
              fontWeight: FontWeight.bold
          ),
        ),

        //New Password Field
        CustomTextField(
          controller: newPasswordController,
          hintText: "Type your password",
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          validator: (password) {
            if (password!.isEmpty) return "Please enter a password";
            return null;
          },
        ),

        const Spacer(),

        //Confirm New Password Label
        Text(
          "Confirm Password",
          style: context.bodyText1.copyWith(
              color: Constants.primaryColor,
              fontSize: 26,
              fontWeight: FontWeight.bold
          ),
        ),

        //Confirm New Password Field
        CustomTextField(
          controller: cNewPasswordController,
          hintText: "Retype your password",
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          validator: (cPassword) {
            if (newPasswordController.text.trim() == cPassword) return null;
            return "Passwords don't match";
          },
        ),
      ],
    );
  }
}


