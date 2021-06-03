import 'package:flutter/material.dart';

//Helpers
import '../../../helper/utils/constants.dart';

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
          const Text(
            "Billing Details",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
          ),

          const SizedBox(height: 15),

          //Billing Summary Labels
          Row(
            children: const [
              SizedBox(
                width: 30,
                child: Text(
                  "Qty",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                "Ticket Type",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                "Price",
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
            children: const [
              SizedBox(
                width: 30,
                child: Text(
                  "3",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Constants.textGreyColor,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                "Normal Seat",
                style: TextStyle(
                  fontSize: 16,
                  color: Constants.textGreyColor,
                ),
              ),
              Spacer(),
              Text(
                "${Constants.ticketPrice}",
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
            children: const [
              Text(
                "Total - Rs. ${3 * Constants.ticketPrice}",
                style: TextStyle(
                  fontSize: 16,
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
