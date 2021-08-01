import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../helper/utils/constants.dart';

//Providers
import '../../../providers/all_providers.dart';

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
      child: Consumer(
        builder: (ctx, watch, _) {
          final theaterSeats = watch(theatersProvider).selectedSeats.length;
          return CustomTextButton.gradient(
            width: double.infinity,
            onPressed: () {
              context.router.push(const TicketSummaryScreenRoute());
            },
            disabled: theaterSeats == 0,
            gradient: Constants.buttonGradientOrange,
            child: Center(
              child: Text(
                'PURCHASE - $theaterSeats SEATS',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  letterSpacing: 0.7,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
