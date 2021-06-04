import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Helpers
import '../../../helper/utils/constants.dart';

//Routes
import '../../../routes/app_router.gr.dart';

//Providers
import '../../../providers/all_providers.dart';

//Widgets
import '../common/custom_text_button.dart';

class MoreBookingsButton extends StatelessWidget {
  const MoreBookingsButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: CustomTextButton(
        width: double.infinity,
        onPressed: () {
          context.read(theatersProvider).clearSelectedSeats();
          context.router.popUntilRouteWithName(MoviesScreenRoute.name);
        },
        color: Constants.textWhite80Color,
        child: const Center(
          child: Text(
            "MAKE MORE BOOKINGS",
            style: TextStyle(
              color: Constants.primaryColor,
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
