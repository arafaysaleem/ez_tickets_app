import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

//Helpers
import '../../../helper/utils/constants.dart';

//Routes
import '../../../routes/app_router.gr.dart';

//Widgets
import '../common/custom_text_button.dart';

class ConfirmBookingsButton extends StatelessWidget {
  const ConfirmBookingsButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: CustomTextButton.gradient(
        width: double.infinity,
        onPressed: () {
          context.router.push(const PaymentScreenRoute());
        },
        gradient: Constants.buttonGradientOrange,
        child: const Center(
          child: Text(
            'CONFIRM',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              letterSpacing: 0.7,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
