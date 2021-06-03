import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../enums/payment_method_enum.dart';
import '../../../helper/extensions/context_extensions.dart';
import '../../../helper/utils/constants.dart';

//Providers
import '../../../providers/all_providers.dart';

class PaymentOptions extends HookWidget {
  const PaymentOptions();

  @override
  Widget build(BuildContext context) {
    final activePaymentMode = useProvider(paymentsProvider.select((provider) {
      return provider.activePaymentMethod;
    }));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Payment Mode Label
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Payment Mode",
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
            children: [
              //COD Button
              Radio<PaymentMethod>(
                value: PaymentMethod.COD,
                fillColor:
                    MaterialStateProperty.all<Color>(Constants.primaryColor),
                activeColor: Constants.primaryColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                groupValue: activePaymentMode,
                onChanged:
                    context.read(paymentsProvider).setActivePaymentMethod,
              ),

              //COD Label
              Text(
                "Cash On Delivery",
                style: context.bodyText1.copyWith(
                  color: Constants.textGreyColor,
                  fontSize: 17,
                ),
              ),

              const SizedBox(width: 20),

              //Card Button
              Radio<PaymentMethod>(
                value: PaymentMethod.CARD,
                fillColor:
                    MaterialStateProperty.all<Color>(Constants.primaryColor),
                activeColor: Constants.primaryColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                groupValue: activePaymentMode,
                onChanged:
                    context.read(paymentsProvider).setActivePaymentMethod,
              ),

              //Card Label
              Text(
                "Card",
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
