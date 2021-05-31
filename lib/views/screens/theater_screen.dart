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
import '../widgets/common/custom_text_button.dart';
import '../widgets/theater/curved_screen.dart';
import '../widgets/theater/seat_color_indicators.dart';
import '../widgets/theater/seats_area.dart';

class TheaterScreen extends HookWidget {
  const TheaterScreen();

  static const _maxRows = 13;
  static const _seatSize = 28.0;
  static const _seatGap = 7.0;
  static const _maxGridHeight = 430.0;

  @override
  Widget build(BuildContext context) {
    final theater = useProvider(showTheaterFuture);
    return theater.when(
      data: (theater) {
        final minScreenWidth = MediaQuery.of(context).size.width;
        var screenWidth = theater.seatsPerRow * (_seatSize + _seatGap) + 20; //for right pad
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
                  const _IconsRow(),

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
                    maxRows: _maxRows,
                    numOfRows: theater.numOfRows,
                    seatsPerRow: theater.seatsPerRow,
                    missing: theater.missing,
                    blocked: theater.blocked,
                    screenScrollController: screenScrollController,
                  ),

                  const Spacer(),

                  //Seat color indicators
                  const SeatColorIndicators(),

                  const Spacer(),

                  //Continue button
                  const _ContinueButton(),

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

  Widget _buildError(error,st) {
      if (error is NetworkException) {
        return Text(error.message);
      }
      debugPrint(error.toString());
      debugPrint(st.toString());
      return Text(error.toString());
    }
}

class _IconsRow extends StatelessWidget {
  const _IconsRow({Key? key}) : super(key: key);

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
          decoration: BoxDecoration(
            color: Colors.white30,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Icon(Icons.close_rounded, size: 23),
          ),
        ),
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
