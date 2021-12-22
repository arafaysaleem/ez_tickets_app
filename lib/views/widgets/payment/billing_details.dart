import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../helper/utils/constants.dart';

//Providers
import '../../../providers/all_providers.dart';

class BillingDetails extends StatelessWidget {
  const BillingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Billing Details Label
          const Text(
            'Billing Details',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
          ),

          const SizedBox(height: 15),

          //Billing Summary Labels
          Row(
            children: const [
              SizedBox(
                width: 40,
                child: Text(
                  'Qty',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                'Ticket Type',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                'Price',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),

          const SizedBox(height: 15),

          //Billing Summary Data
          Row(
            children: [
              //Num of tickets
              SizedBox(
                width: 40,
                child: Consumer(
                  builder: (ctx, ref, _) {
                    final numSeats = ref.watch(theatersProvider).selectedSeats.length;
                    return Text(
                      '$numSeats',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Constants.textGreyColor,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(width: 10),

              //Seat type
              const Text(
                'Normal Seat',
                style: TextStyle(
                  fontSize: 16,
                  color: Constants.textGreyColor,
                ),
              ),
              const Spacer(),

              //Price
              const Text(
                '${Constants.ticketPrice}',
                style: TextStyle(
                  fontSize: 16,
                  color: Constants.textGreyColor,
                ),
              )
            ],
          ),

          const Divider(color: Colors.black, thickness: 0.8),

          //Billing Total
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Consumer(
                builder: (ctx, ref, _) {
                  final numSeats = ref.watch(theatersProvider).selectedSeats.length;
                  return Text(
                    'Total - Rs. ${numSeats * Constants.ticketPrice}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
