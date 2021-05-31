import 'package:flutter/material.dart';

//Helpers
import '../../../helper/utils/constants.dart';

//Widgets
import '../common/custom_text_button.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomTextButton.gradient(
        width: double.infinity,
        onPressed: () {},
        gradient: Constants.buttonGradientOrange,
        child: const Center(
          child: Text(
            "PURCHASE - X SEATS",
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
