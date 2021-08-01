import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Helpers
import '../../../enums/show_type_enum.dart';
import '../../../helper/utils/constants.dart';

class BookingSummaryRow extends StatelessWidget {
  final String title;
  final int noOfSeats;
  final double total;
  final DateTime showDateTime;
  final ShowType showType;

  const BookingSummaryRow({
    Key? key,
    required this.total,
    required this.title,
    required this.noOfSeats,
    required this.showDateTime,
    required this.showType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
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

                  //Show type row
                  Row(
                    children: [
                      //Show type icon
                      const Icon(
                        Icons.hd_outlined,
                        size: 19,
                        color: Colors.blue,
                      ),

                      const SizedBox(width: 10),

                      //Show status
                      Text(
                        showType.inString,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Constants.textWhite80Color,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  //Show timings row
                  Row(
                    children: [
                      //Show date icon
                      const Icon(
                        Icons.date_range_outlined,
                        size: 19,
                        color: Constants.primaryColor,
                      ),

                      const SizedBox(width: 10),

                      //Show time data
                      Text(
                        DateFormat('d MMMM,yy H:m').format(showDateTime),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Constants.textWhite80Color,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  //Show payment row
                  Row(
                    children: [
                      //Total icon
                      const Icon(
                        Icons.local_atm_outlined,
                        size: 19,
                        color: Colors.green,
                      ),

                      const SizedBox(width: 10),

                      //Total data
                      Text(
                        'Rs. $total',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Constants.textWhite80Color,
                        ),
                      ),
                    ],
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
                    '$noOfSeats',
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
