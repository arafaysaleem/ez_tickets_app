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

class PayButton extends ConsumerWidget {
  const PayButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: CustomTextButton.gradient(
        width: double.infinity,
        onPressed: () {
          ref.read(paymentsProvider).makePayment();
          AppRouter.pushNamed(Routes.ConfirmationScreenRoute);
        },
        gradient: Constants.buttonGradientOrange,
        child: const Center(
          child: Text(
            'PAY',
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
