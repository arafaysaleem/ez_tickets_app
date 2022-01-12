import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../helper/utils/constants.dart';

//Providers
import '../../../providers/all_providers.dart';

//Routing
import '../../../routes/routes.dart';
import '../../../routes/app_router.dart';

//Widgets
import '../common/custom_text_button.dart';

class PurchaseSeatsButton extends StatelessWidget {
  const PurchaseSeatsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Consumer(
        builder: (ctx, ref, _) {
          final theaterSeats = ref.watch(theatersProvider).selectedSeats.length;
          return CustomTextButton.gradient(
            width: double.infinity,
            onPressed: () {
              AppRouter.pushNamed(Routes.TicketSummaryScreenRoute);
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
