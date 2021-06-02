import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

//Helpers
import '../../../helper/utils/constants.dart';

//Routes
import '../../../routes/app_router.gr.dart';

//Widgets
import '../common/custom_text_button.dart';

class PurchaseSeatsButton extends StatelessWidget {
  const PurchaseSeatsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomTextButton.gradient(
        width: double.infinity,
        onPressed: () {
          context.router.push(const TicketSummaryScreenRoute());
        },
        gradient: Constants.buttonGradientOrange,
        child: const Center(
          //TODO: Wrap in consumer and display seats list length instead of X
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
