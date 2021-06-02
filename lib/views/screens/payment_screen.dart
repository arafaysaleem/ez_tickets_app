import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../enums/payment_method_enum.dart';
import '../../helper/extensions/context_extensions.dart';
import '../../helper/utils/constants.dart';

//Providers
import '../../providers/all_providers.dart';

//Widgets
import '../widgets/payment/pay_button.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            //Back icon and title
            const _BackIconRow(),

            const SizedBox(height: 30),

            //Bill Details White Box
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(vertical: 15),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Billing Details Label
                    const BillingDetails(),

                    const SizedBox(height: 25),

                    //Payment Mode Label
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        "Payment Mode",
                        style: context.textTheme.headline4!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    //Payment Mode Options
                    const PaymentOptions(),

                    const SizedBox(height: 25),

                    //Mode Details Form
                    const ModeDetailsInput(),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            //Pay Button
            const PayButton(),

            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

class _BackIconRow extends StatelessWidget {
  const _BackIconRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 15),
        InkResponse(
          radius: 25,
          child: const Icon(Icons.arrow_back_sharp, size: 26),
          onTap: () {
            context.router.pop();
          },
        ),

        const SizedBox(width: 65),

        //Title
        Text(
          'Payment Options',
          style: context.headline5.copyWith(fontSize: 20),
        ),

        const Spacer(),
      ],
    );
  }
}

class PaymentOptions extends HookWidget {
  const PaymentOptions();

  @override
  Widget build(BuildContext context) {
    final activePaymentMode = useProvider(paymentsProvider.select((provider) {
      return provider.activePaymentMethod;
    }));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          //COD Button
          Radio<PaymentMethod>(
            value: PaymentMethod.COD,
            fillColor: MaterialStateProperty.all<Color>(Constants.primaryColor),
            activeColor: Constants.primaryColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            groupValue: activePaymentMode,
            onChanged: context.read(paymentsProvider).setActivePaymentMethod,
          ),

          //COD Label
          const Text(
            "Cash On Delivery",
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
            ),
          ),

          const SizedBox(width: 20),

          //Card Button
          Radio<PaymentMethod>(
            value: PaymentMethod.CARD,
            fillColor: MaterialStateProperty.all<Color>(Constants.primaryColor),
            activeColor: Constants.primaryColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            groupValue: activePaymentMode,
            onChanged: context.read(paymentsProvider).setActivePaymentMethod,
          ),

          //Card Label
          const Text(
            "Card",
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}

class BillingDetails extends StatelessWidget {
  const BillingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Billing Details Label
          Text(
            "Billing Details",
            style: context.textTheme.headline4!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          //Billing Summary Labels
          Row(
            children: const [
              SizedBox(
                width: 30,
                child: Text(
                  "Qty",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                "Ticket Type",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                "Price",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),

          const Divider(color: Constants.textGreyColor,thickness: 0.8),

          //Billing Summary Data
          Row(
            children: const [
              SizedBox(
                width: 30,
                child: Text(
                  "3",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    color: Constants.textGreyColor,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                "Normal Seat",
                style: TextStyle(
                  fontSize: 17,
                  color: Constants.textGreyColor,
                ),
              ),
              Spacer(),
              Text(
                "${Constants.ticketPrice}",
                style: TextStyle(
                  fontSize: 17,
                  color: Constants.textGreyColor,
                ),
              )
            ],
          ),

          const Divider(color: Constants.textGreyColor,thickness: 0.8),

          //Billing Total
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text(
                "Total - Rs. ${3 * Constants.ticketPrice}",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ModeDetailsInput extends HookWidget {
  const ModeDetailsInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activeMode = useProvider(paymentsProvider.select((provider) {
      return provider.activePaymentMethod;
    }));
    final formMode = activeMode == PaymentMethod.COD ? "Delivery" : "Card";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          //Payment Mode Details Label
          Text(
            "$formMode Details",
            style: context.textTheme.headline4!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          //Payment Mode Details Form
        ],
      ),
    );
  }
}
