import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Helpers
import '../../helper/utils/constants.dart';

//Providers
import '../../providers/payments_provider.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: Constants.buttonGradientRed,
          ),
          child: Center(
            child: Consumer(
              builder: (ctx, watch, child) {
                final _paymentStatus = watch(paymentStateProvider).state;
                return _paymentStatus.maybeWhen(
                  successful: () => Column(
                    children: const [
                      Icon(
                        Icons.check_circle_outline_rounded,
                        color: Colors.white,
                        size: 32,
                      ),

                      SizedBox(height: 10),

                      //Text
                      Expanded(
                        child: Text(
                          "Your tickets have been booked!",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  failed: (reason) => Column(
                    children: [
                      const Icon(
                        Icons.cancel_outlined,
                        color: Colors.white,
                        size: 32,
                      ),

                      const SizedBox(height: 10),

                      //Text
                      Expanded(
                        child: Text(
                          reason,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  orElse: () => const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
