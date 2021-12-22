import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//Helpers
import '../../helper/utils/constants.dart';

//Providers
import '../../providers/payments_provider.dart';

//Widgets
import '../widgets/confirmation/more_bookings_button.dart';
import '../widgets/confirmation/retry_payment_button.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: () async => false,
        child: Container(
          decoration: const BoxDecoration(
            gradient: Constants.buttonGradientOrange,
          ),
          padding: const EdgeInsets.only(bottom: Constants.bottomInsetsLow+5),
          child: Consumer(
            builder: (ctx, ref, child) {
              final _paymentStatus = ref.watch(paymentStateProvider);
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 550),
                switchInCurve: Curves.easeInBack,
                child: _paymentStatus.when(
                  unprocessed: () => Column(
                    key: UniqueKey(),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Spacer(),

                      SpinKitRing(
                        color: Colors.white,
                        duration: Duration(milliseconds: 1000),
                        size: 64,
                      ),

                      SizedBox(height: 10),

                      //Text
                      Expanded(
                        child: Text(
                          'Initializing payment',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  processing: () => Column(
                    key: UniqueKey(),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Spacer(),

                      SpinKitPouringHourGlass(
                        color: Colors.white,
                        duration: Duration(milliseconds: 1100),
                        size: 64,
                      ),

                      SizedBox(height: 10),

                      //Text
                      Expanded(
                        child: Text(
                          'Processing payment',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  successful: () => Column(
                    key: UniqueKey(),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Spacer(),

                      Icon(
                        Icons.check_circle_outline_rounded,
                        color: Colors.white,
                        size: 64,
                      ),

                      SizedBox(height: 10),

                      //Text
                      Expanded(
                        child: Text(
                          'Your tickets have been booked!',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      MoreBookingsButton(),
                    ],
                  ),
                  failed: (reason) {
                    debugPrint(reason);
                    return Column(
                      key: UniqueKey(),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Spacer(),

                        Icon(
                          Icons.cancel_outlined,
                          color: Colors.white,
                          size: 64,
                        ),

                        SizedBox(height: 10),

                        //Text
                        Expanded(
                          child: Text(
                            'Payment Failed',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        RetryPaymentButton(),

                        SizedBox(height: 20),

                        MoreBookingsButton(),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
