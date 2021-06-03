import 'package:flutter/material.dart';

//Helpers
import '../../helper/utils/constants.dart';
import '../../helper/extensions/context_extensions.dart';

//Widgets
import '../widgets/common/shimmer_loader.dart';

class TheaterSkeletonLoader extends StatelessWidget {
  const TheaterSkeletonLoader();

  static const _seatSize = 28.0;
  static const _maxGridHeight = 430.0;
  static const _maxSeatRows = Constants.maxSeatRows-2;
  static const _numSeatsPerRow = 9;

  @override
  Widget build(BuildContext context) {
    var screenWidth = context.screenWidth;
    return ShimmerLoader(
      child: Column(
        children: [
          //Curved Screen Skeleton
          CustomPaint(
            size: Size(screenWidth, (screenWidth * 0.1).toDouble()),
            painter: const _ScreenSkeletonPainter(),
          ),

          const Spacer(),

          //Seats Box
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SizedBox(
              height: _maxGridHeight * _maxSeatRows/Constants.maxSeatRows,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Seat letters' column
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var i = 0; i < _maxSeatRows; i++)
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
                  ),

                  const SizedBox(width: 10),

                  //Seats
                  Flexible(
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Constants.lightSkeletonColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (var i = 0; i < _maxSeatRows; i++)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  for (var j = 0; j < _numSeatsPerRow; j++)
                                    const SizedBox(
                                      height: _seatSize,
                                      width: _seatSize,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Constants.darkSkeletonColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),
                                      ),
                                    )
                                ],
                              )
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

          //Seat indicator boxes
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var i = 0; i < 3; i++)
                  const SizedBox(
                    height: 18,
                    width: 90,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Constants.lightSkeletonColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  )
              ],
            ),
          ),

          const Spacer(),

          //Chips Boxes
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var i = 0; i < 4; i++)
                  const SizedBox(
                    height: 27,
                    width: 60,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Constants.lightSkeletonColor,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Constants.darkSkeletonColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                  ),
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: SizedBox(
                    height: 27,
                    width: 50,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Constants.lightSkeletonColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Constants.darkSkeletonColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

          //Continue button
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 55,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Constants.lightSkeletonColor,
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Constants.darkSkeletonColor,
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 5),
        ],
      ),
    );
  }
}

class _ScreenSkeletonPainter extends CustomPainter {
  const _ScreenSkeletonPainter();

  @override
  void paint(Canvas canvas, Size size) {
    var paint_0 = Paint()
      ..color = Constants.lightSkeletonColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    var path_0 = Path()
      ..moveTo(size.width * 0.0685714, size.height * 0.5)
      ..quadraticBezierTo(
        size.width * 0.4917857,
        size.height * -0.2425,
        size.width * 0.9257143,
        size.height * 0.5,
      );

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
