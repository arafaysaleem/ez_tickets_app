import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Helpers
import '../../../helper/utils/constants.dart';

//Routing
import '../../../routes/routes.dart';
import '../../../routes/app_router.dart';

//Providers
import '../../../providers/all_providers.dart';

//Widgets
import '../common/custom_text_button.dart';

class MoreBookingsButton extends ConsumerWidget {
  const MoreBookingsButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: CustomTextButton(
        width: double.infinity,
        onPressed: () {
          ref.read(theatersProvider).clearSelectedSeats();
          AppRouter.popUntil(Routes.MoviesScreenRoute);
        },
        color: Constants.textWhite80Color,
        child: const Center(
          child: Text(
            'MAKE MORE BOOKINGS',
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
