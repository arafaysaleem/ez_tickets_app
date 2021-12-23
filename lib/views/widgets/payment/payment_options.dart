import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../enums/payment_method_enum.dart';
import '../../../helper/extensions/context_extensions.dart';
import '../../../helper/utils/constants.dart';

//Providers
import '../../../providers/payments_provider.dart';

class PaymentOptions extends HookConsumerWidget {
  const PaymentOptions();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activePaymentMode = ref.watch(activePaymentModeProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Payment Mode Label
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Payment Mode',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
              color: Constants.textWhite80Color,
            ),
          ),
        ),

        const SizedBox(height: 5),

        //Payment options
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //On Hand Cash Button
              Radio<PaymentMethod>(
                value: PaymentMethod.CASH,
                fillColor:
                MaterialStateProperty.all<Color>(Constants.primaryColor),
                activeColor: Constants.primaryColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                groupValue: activePaymentMode,
                onChanged:(mode) {
                  ref.read(activePaymentModeProvider.state).state = mode!;
                },
              ),

              //On Hand Cash Label
              Text(
                'On Hand Cash',
                style: context.bodyText1.copyWith(
                  color: Constants.textGreyColor,
                  fontSize: 17,
                ),
              ),

              const SizedBox(width: 10),

              //Card Button
              Radio<PaymentMethod>(
                value: PaymentMethod.CARD,
                fillColor:
                    MaterialStateProperty.all<Color>(Constants.primaryColor),
                activeColor: Constants.primaryColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                groupValue: activePaymentMode,
                onChanged:(mode) {
                  ref.read(activePaymentModeProvider.state).state = mode!;
                },
              ),

              //Card Label
              Text(
                'Card',
                style: context.bodyText1.copyWith(
                  color: Constants.textGreyColor,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //COD Button
              Radio<PaymentMethod>(
                value: PaymentMethod.COD,
                fillColor:
                MaterialStateProperty.all<Color>(Constants.primaryColor),
                activeColor: Constants.primaryColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                groupValue: activePaymentMode,
                onChanged:(mode) {
                  ref.read(activePaymentModeProvider.state).state = mode!;
                },
              ),

              //COD Label
              Text(
                'Cash On Delivery',
                style: context.bodyText1.copyWith(
                  color: Constants.textGreyColor,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
