import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

//Helpers
import '../../../helper/utils/constants.dart';

//Routes
import '../../../routes/app_router.gr.dart';

//Widgets
import '../common/custom_text_button.dart';

class SuccessfulResetWidget extends StatelessWidget {
  final String? successMessage;

  const SuccessfulResetWidget({
    Key? key,
    required this.successMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //Success message
        Text(
          successMessage ?? 'Password reset successfully, login to access features',
          style: const TextStyle(
            fontSize: 17,
            color: Constants.primaryColor,
          ),
        ),

        const SizedBox(height: 20),

        //Proceed button
        CustomTextButton.gradient(
          width: double.infinity,
          onPressed: () => context.router.push(const LoginScreenRoute()),
          gradient: Constants.buttonGradientOrange,
          child: const Center(
            child: Text(
              'PROCEED TO LOGIN',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                letterSpacing: 0.7,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
