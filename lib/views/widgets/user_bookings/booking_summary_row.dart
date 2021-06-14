import 'package:flutter/material.dart';

import '../../../helper/utils/constants.dart';

class BookingSummaryRow extends StatelessWidget {
  final String title;
  final int noOfSeats;
  final double total;

  const BookingSummaryRow({
    Key? key,
    required this.total,
    required this.title,
    required this.noOfSeats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Ticket total and movie name
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Constants.scaffoldGreyColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(125, 10, 5, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Movie data
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Constants.textWhite80Color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Spacer(),

                  //Total label
                  const Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 13,
                      color: Constants.textGreyColor,
                    ),
                  ),

                  const SizedBox(height: 1),

                  //Total data
                  Text(
                    "Rs. $total",
                    style: const TextStyle(
                      fontSize: 15,
                      color: Constants.textWhite80Color,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //No of seats
          SizedBox(
            height: double.infinity,
            width: 45,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: Constants.buttonGradientRed,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Ticket icon
                  const Icon(
                    Icons.local_activity_sharp,
                    color: Constants.textWhite80Color,
                  ),

                  const SizedBox(height: 5),

                  //No. of seats
                  Text(
                    "$noOfSeats",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Constants.textWhite80Color,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
