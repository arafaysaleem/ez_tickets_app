import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../helper/utils/constants.dart';
import '../widgets/common/custom_text_button.dart';

class TicketSummaryScreen extends StatelessWidget {
  const TicketSummaryScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            //Back icon and title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 15),
                GestureDetector(
                  child: const Icon(Icons.arrow_back_sharp, size: 26),
                  onTap: () {
                    context.router.pop();
                  },
                ),

                const SizedBox(width: 90),

                //Movie Title
                Text(
                  'Your tickets',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontSize: 18),
                ),

                const Spacer(),
              ],
            ),

            const SizedBox(height: 20),

            //Tickets Box
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.72,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    //Movie Picture
                    Container(
                      height: 280,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(9),
                          topRight: Radius.circular(9),
                        ),
                      ),
                    ),

                    //Show details
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Date
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Date",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Constants.textGreyColor,
                                ),
                              ),
                              Text(
                                "Sat, 5 Feb, 2019",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          //Time
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Time",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Constants.textGreyColor,
                                ),
                              ),
                              Text(
                                "17:30",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          //Theater
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Theater",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Constants.textGreyColor,
                                ),
                              ),
                              Text(
                                "A",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    //Separator
                    SizedBox(
                      height: 20,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          //Dotted line
                          Row(
                            children: [
                              for (int i = 0; i < 30; i++)
                                const Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2),
                                    child: Divider(
                                      color: Colors.black,
                                      height: 2,
                                      thickness: 1.5,
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          //Left circle cut
                          const Positioned(
                            left: -25,
                            child: SizedBox(
                              height: 20,
                              width: 50,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),

                          //Right circle cut
                          const Positioned(
                            right: -25,
                            child: SizedBox(
                              height: 20,
                              width: 50,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Ticket details
                    Expanded(
                      child: ListView.separated(
                        itemCount: 6,
                        separatorBuilder: (_, i) => SizedBox(
                          height: 20,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              //Dotted line
                              Row(
                                children: [
                                  for (int i = 0; i < 30; i++)
                                    const Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2),
                                        child: Divider(
                                          color: Colors.black,
                                          height: 2,
                                          thickness: 1.5,
                                        ),
                                      ),
                                    ),
                                ],
                              ),

                              //Left circle cut
                              const Positioned(
                                left: -25,
                                child: SizedBox(
                                  height: 20,
                                  width: 50,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),

                              //Right circle cut
                              const Positioned(
                                right: -25,
                                child: SizedBox(
                                  height: 20,
                                  width: 50,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        itemBuilder: (_, i) => Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(9),
                              bottomRight: Radius.circular(9),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Seat icon
                              const Icon(
                                Icons.event_seat,
                                color: Constants.primaryColor,
                              ),

                              //Seat
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Seat:",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Constants.textGreyColor,
                                    ),
                                  ),
                                  Text(
                                    "A-13",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              //Price
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Price",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Constants.textGreyColor,
                                    ),
                                  ),
                                  Text(
                                    "Rs. 700",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            //Confirm Button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: CustomTextButton.gradient(
                width: double.infinity,
                onPressed: () {},
                gradient: Constants.buttonGradientOrange,
                child: const Center(
                  child: Text(
                    "CONFIRM",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      letterSpacing: 0.7,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
