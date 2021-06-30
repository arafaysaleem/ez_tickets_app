import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Providers
import '../../../providers/all_providers.dart';

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
      children: [

        //Current Password Field
        CustomTextField(
          hintText: "Enter current password",
          floatingText: "Current Password",
          controller: currentPasswordController,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          validator: (currPassword) {
            final authProv = context.read(authProvider.notifier);
            if (authProv.currentUserPassword == currPassword) return null;
            return "Invalid current password!";
          },
        ),

        const SizedBox(height: 25),

        //New Password Field
        CustomTextField(
          hintText: "Type your password",
          floatingText: "New Password",
          controller: newPasswordController,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          validator: (password) {
            final authProv = context.read(authProvider.notifier);
            if (password!.isEmpty) {
              return "Please enter a password";
            }
            else if(authProv.currentUserPassword == password) {
              return "Current and new password can't be same";
            }
            return null;
          },
        ),

        const SizedBox(height: 25),

        //Confirm New Password Field
        CustomTextField(
          hintText: "Retype your password",
          floatingText: "New Password",
          controller: cNewPasswordController,
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
