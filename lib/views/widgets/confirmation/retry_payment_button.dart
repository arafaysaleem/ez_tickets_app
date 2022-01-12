import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Helpers
import '../../../helper/utils/constants.dart';

//Providers
import '../../../providers/all_providers.dart';

//Widgets
import '../common/custom_text_button.dart';

class RetryPaymentButton extends ConsumerWidget {
  const RetryPaymentButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: CustomTextButton.outlined(
        width: double.infinity,
        onPressed: () => ref.read(paymentsProvider).makePayment(),
        border: Border.all(color: Constants.textWhite80Color,width: 4),
        child: const Center(
          child: Text(
            'RETRY PAYMENT',
            style: TextStyle(
              color: Constants.textWhite80Color,
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
