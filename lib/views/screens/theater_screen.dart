import 'dart:ui' as ui;

import 'package:flutter_hooks/flutter_hooks.dart';

import '../widgets/common/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

//Helpers
import '../../helper/utils/constants.dart';

class TheaterScreen extends HookWidget {
  const TheaterScreen();

  bool isMissing(
      List<Map<String, dynamic>> missing,
      Map<String, dynamic> seat,
      ) {
    for (var mSeat in missing) {
      if (mSeat["seat_row"] == seat["seat_row"] &&
          mSeat["seat_number"] == seat["seat_number"]) {
        return true;
      }
    }
    return false;
  }

  bool isBlocked(
      List<Map<String, dynamic>> blocked,
      Map<String, dynamic> seat,
      ) {
    return isMissing(blocked, seat);
  }

  @override
  Widget build(BuildContext context) {
    const theater = <String, dynamic>{
      "theater_id": 15,
      "theater_name": "C",
      "num_of_rows": 12,
      "seats_per_row": 15,
      "theater_type": "normal",
      "missing": [
        {"seat_row": "A", "seat_number": 4},
        {"seat_row": "B", "seat_number": 4},
        {"seat_row": "C", "seat_number": 4},
        {"seat_row": "D", "seat_number": 4},
        {"seat_row": "E", "seat_number": 4},
        {"seat_row": "F", "seat_number": 4},
        {"seat_row": "G", "seat_number": 4},
        {"seat_row": "H", "seat_number": 4},
        {"seat_row": "I", "seat_number": 4},
        {"seat_row": "J", "seat_number": 4},
        {"seat_row": "K", "seat_number": 4},
        {"seat_row": "L", "seat_number": 4},
        {"seat_row": "E", "seat_number": 0},
        {"seat_row": "E", "seat_number": 1},
        {"seat_row": "E", "seat_number": 2},
        {"seat_row": "E", "seat_number": 3},
        {"seat_row": "G", "seat_number": 0},
        {"seat_row": "G", "seat_number": 1},
        {"seat_row": "G", "seat_number": 2},
        {"seat_row": "G", "seat_number": 3},
        {"seat_row": "F", "seat_number": 0},
        {"seat_row": "F", "seat_number": 1},
        {"seat_row": "F", "seat_number": 2},
        {"seat_row": "F", "seat_number": 3},
      ],
      "blocked": [
        {"seat_row": "C", "seat_number": 5},
        {"seat_row": "D", "seat_number": 0},
        {"seat_row": "D", "seat_number": 2},
        {"seat_row": "H", "seat_number": 5},
        {"seat_row": "H", "seat_number": 6},
        {"seat_row": "H", "seat_number": 2},
        {"seat_row": "H", "seat_number": 3},
        {"seat_row": "I", "seat_number": 5},
        {"seat_row": "I", "seat_number": 8},
        {"seat_row": "I", "seat_number": 6},
        {"seat_row": "I", "seat_number": 0},
        {"seat_row": "J", "seat_number": 0},
        {"seat_row": "J", "seat_number": 1},
        {"seat_row": "J", "seat_number": 2},
      ]
    };
    const maxRows = 13;
    final int seatsPerRow = theater["seats_per_row"];
    final int numOfRows = theater["num_of_rows"];
    const seatSize = 28.0;
    const seatGap = 7.0;
    const maxGridHeight = 430.0;
    final minScreenWidth = MediaQuery.of(context).size.width;
    final List<Map<String, dynamic>> missing = theater["missing"];
    final List<Map<String, dynamic>> booked = theater["blocked"];
    var screenWidth = seatsPerRow * (seatSize + seatGap) + 20; //for right pad
    if(screenWidth < minScreenWidth) screenWidth = minScreenWidth;
    late final screenScrollController = useScrollController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              //Icons row
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: InkResponse(
                  radius: 25,
                  onTap: () {
                    context.router.pop();
                  },
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.white30,
                        shape: BoxShape.circle
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.close_rounded, size: 23),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              //Screen
              SingleChildScrollView(
                controller: screenScrollController,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: CustomPaint(
                  size: Size(
                    screenWidth,
                    (screenWidth * 0.1).toDouble(), // * 0.143 was original
                  ),
                  painter: ScreenPainter(),
                ),
              ),

              const Spacer(),

              //Seats Area
              SizedBox(
                height: maxGridHeight * numOfRows / maxRows,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Seat letters' column
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var i = 0; i < numOfRows; i++)
                          SizedBox(
                            height: 26.5,
                            child: Center(
                              child: Text(
                                String.fromCharCode(i + 65),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                      ],
                    ),

                    const SizedBox(width: 10),

                    //Seats
                    NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll){
                        overScroll.disallowGlow();
                        return true;
                      },
                      child: Flexible(
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (scrollInfo) {
                            if (scrollInfo is ScrollUpdateNotification) {
                              screenScrollController.jumpTo(
                                scrollInfo.metrics.pixels,
                              );
                            }
                            return true;
                          },
                          child: GridView.builder(
                            itemCount: numOfRows * seatsPerRow,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(right: 20),
                            gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: seatSize,
                              crossAxisSpacing: seatGap,
                              mainAxisSpacing: seatGap,
                            ),
                            itemBuilder: (ctx, i) {
                              final seatRowLetter =
                              String.fromCharCode(i % numOfRows + 65);
                              final seatRowNumber = i ~/ numOfRows;
                              final seat = {
                                "seat_row": seatRowLetter,
                                "seat_number": seatRowNumber,
                              };
                              if (isMissing(missing, seat)) {
                                return const SizedBox.shrink();
                              } else if (isBlocked(booked, seat)) {
                                return const DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF424242),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                );
                              }
                              return const _SeatWidget();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              //Seat color indicators
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Available
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        //Color indicator circle
                        SizedBox(
                          height: 12,
                          width: 12,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),

                        SizedBox(width: 10),

                        Text(
                          "Available",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),

                    //Taken
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        //Color indicator circle
                        SizedBox(
                          height: 12,
                          width: 12,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Color(0xFF424242),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),

                        SizedBox(width: 10),

                        Text(
                          "Taken",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),

                    //Selected
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        //Color indicator circle
                        SizedBox(
                          height: 12,
                          width: 12,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Constants.redColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),

                        SizedBox(width: 10),

                        Text(
                          "Selected",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              const Spacer(),

              //Continue button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextButton.gradient(
                  width: double.infinity,
                  onPressed: () {},
                  gradient: Constants.buttonGradientOrange,
                  child: const Center(
                    child: Text(
                      "PURCHASE - X SEATS",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        letterSpacing: 0.7,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: Constants.bottomInsetsLow),
            ],
          ),
        ),
      ),
    );
  }
}

class _SeatWidget extends StatefulWidget {
  const _SeatWidget({
    Key? key,
  }) : super(key: key);

  @override
  __SeatWidgetState createState() => __SeatWidgetState();
}

class __SeatWidgetState extends State<_SeatWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: isSelected ? const DecoratedBox(
        decoration: BoxDecoration(
          color: Constants.redColor,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ) : const DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    );
  }
}

class ScreenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint_0 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6;

    var path_0 = Path()
      ..moveTo(size.width * 0.0685714, size.height * 0.5)
      ..quadraticBezierTo(
        size.width * 0.4917857,
        size.height * -0.2425,
        size.width * 0.9257143,
        size.height * 0.5,
      );

    canvas.drawPath(path_0, paint_0);

    var paint_1 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 3;

    paint_1.shader = ui.Gradient.linear(
      Offset(size.width * 0.50, size.height * -0.00),
      Offset(size.width * 0.50, size.height * 1.00),
      const [Color(0xcbffffff), Color(0x4dffffff), Color(0x00ffffff)],
      const [0.00, 0.16, 1.00],
    );

    var path_1 = Path()
      ..moveTo(size.width * 0.0382429, size.height * 1.0022)
      ..quadraticBezierTo(
        size.width * 0.0597857,
        size.height * 0.6254,
        size.width * 0.0669571,
        size.height * 0.5,
      )
      ..cubicTo(
        size.width * 0.2820143,
        size.height * 0.0483,
        size.width * 0.6836,
        size.height * -0.0022,
        size.width * 0.9273286,
        size.height * 0.5,
      )
      ..quadraticBezierTo(
        size.width * 0.9345,
        size.height * 0.6254,
        size.width * 0.9560429,
        size.height * 1.0022,
      )
      ..lineTo(size.width * 0.0382429, size.height * 1.0022)
      ..close();

    canvas.drawPath(path_1, paint_1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
