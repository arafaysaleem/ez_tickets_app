import 'package:flutter/material.dart';

//Helpers
import '../../helper/utils/constants.dart';
import '../../helper/extensions/context_extensions.dart';

//Routing
import '../../routes/app_router.dart';

//Widgets
import '../widgets/common/scrollable_column.dart';
import '../widgets/payment/pay_button.dart';
import '../widgets/payment/billing_details.dart';
import '../widgets/payment/mode_details_input.dart';
import '../widgets/payment/payment_options.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ScrollableColumn(
            children: [
              const SizedBox(height: 20),

              //Back icon and title
              const _BackIconRow(),

              const SizedBox(height: 20),

              //Bill Details White Box
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
                child: const BillingDetails(),
              ),

              const SizedBox(height: 20),

              //Payment Details Black Box
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    color: Constants.scaffoldGreyColor,
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      //Payment Mode Options
                      PaymentOptions(),

                      //Mode Details Form
                      Expanded(child: ModeDetailsInput()),
                    ],
                  ),
                ),
              ),

              //Pay Button
              const PayButton(),

              const SizedBox(height: 5),
            ],
          ),
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
            AppRouter.pop();
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
