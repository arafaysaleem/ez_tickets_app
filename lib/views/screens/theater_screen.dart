import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../helper/utils/constants.dart';

//Providers
import '../../providers/theaters_provider.dart';

//Services
import '../../services/networking/network_exception.dart';

//Widgets
import '../widgets/common/custom_chips_list.dart';
import '../widgets/theater/curved_screen.dart';
import '../widgets/theater/seats_area.dart';
import '../widgets/theater/seat_color_indicators.dart';
import '../widgets/theater/continue_button.dart';

class TheaterScreen extends HookWidget {
  const TheaterScreen();

  static const _seatSize = 28.0;
  static const _seatGap = 7.0;
  static const _maxGridHeight = 430.0;

  @override
  Widget build(BuildContext context) {
    final showSeatingModelFuture = useProvider(showSeatingFuture);
    return showSeatingModelFuture.when(
      data: (showSeatingModel) {
        final theater = showSeatingModel.theater;
        final minScreenWidth = MediaQuery.of(context).size.width;
        var screenWidth = theater.seatsPerRow * (_seatSize + _seatGap);
        if (screenWidth < minScreenWidth) screenWidth = minScreenWidth;
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
                  const _BackIcon(),

                  const SizedBox(height: 10),

                  //Screen
                  CurvedScreen(
                    screenScrollController: screenScrollController,
                    screenWidth: screenWidth,
                  ),

                  const Spacer(),

                  //Seats Area
                  SeatsArea(
                    maxGridHeight: _maxGridHeight,
                    seatSize: _seatSize,
                    seatGap: _seatGap,
                    maxRows: Constants.maxSeatRows,
                    numOfRows: theater.numOfRows,
                    seatsPerRow: theater.seatsPerRow,
                    missing: theater.missing,
                    blocked: theater.blocked,
                    booked: showSeatingModel.bookedSeats,
                    screenScrollController: screenScrollController,
                  ),

                  const Spacer(),

                  //Seat color indicators
                  const SeatColorIndicators(),

                  const Spacer(),

                  //Selected Seats Chips
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: CustomChipsList(
                      chipContents: const ["A-13", "B-5", "D-3", "A-13", "B-5", "D-3"],
                      chipHeight: 27,
                      chipGap: 10,
                      fontSize: 14,
                      chipWidth: 60,
                      borderColor: Constants.orangeColor,
                      contentColor: Constants.orangeColor,
                      borderWidth: 1.5,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.red.shade700.withOpacity(0.3),
                      physics: const BouncingScrollPhysics(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  //Continue button
                  const ContinueButton(),

                  const SizedBox(height: Constants.bottomInsetsLow),
                ],
              ),
            ),
          ),
        );
      },
      loading: _buildLoading,
      error: _buildError,
    );
  }

  Widget _buildLoading() => const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Constants.primaryColor),
        ),
      );

  Widget _buildError(error, st) {
    if (error is NetworkException) {
      return Text(error.message);
    }
    debugPrint(error.toString());
    debugPrint(st.toString());
    return Text(error.toString());
  }
}

class _BackIcon extends StatelessWidget {
  const _BackIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: InkResponse(
        radius: 25,
        onTap: () {
          context.router.pop();
        },
        child: const DecoratedBox(
          decoration:
              BoxDecoration(color: Colors.white30, shape: BoxShape.circle),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Icon(Icons.arrow_back_rounded, size: 23),
          ),
        ),
      ),
    );
  }
}
