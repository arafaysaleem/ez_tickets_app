import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../helper/utils/constants.dart';
import '../../helper/extensions/context_extensions.dart';

//Providers
import '../../providers/theaters_provider.dart';
import '../../providers/all_providers.dart';

//Services
import '../../services/networking/network_exception.dart';

//Widgets
import '../widgets/common/custom_chips_list.dart';
import '../widgets/common/custom_error_widget.dart';
import '../widgets/theater/purchase_seats_button.dart';
import '../widgets/theater/curved_screen.dart';
import '../widgets/theater/seat_color_indicators.dart';
import '../widgets/theater/seats_area.dart';

//Skeletons
import '../skeletons/theater_skeleton_loader.dart';

class TheaterScreen extends HookWidget {
  const TheaterScreen();

  static const _seatSize = 28.0;
  static const _seatGap = 7.0;
  static const _maxGridHeight = 430.0;

  @override
  Widget build(BuildContext context) {
    final showSeatingModelFuture = useProvider(showSeatingFuture);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              //Icons row
              const _BackIcon(),

              const SizedBox(height: 5),

              //Theater details
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 550),
                  switchOutCurve: Curves.easeInBack,
                  child: showSeatingModelFuture.when(
                    data: (showSeatingModel) {
                      final theater = showSeatingModel.theater;
                      final minScreenWidth = context.screenWidth;
                      var screenWidth = theater.seatsPerRow * (_seatSize + _seatGap);
                      screenWidth = max(screenWidth, minScreenWidth);
                      late final screenScrollController = useScrollController();
                      return Column(
                        children: [
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
                            padding: const EdgeInsets.fromLTRB(20, 2, 0, 22),
                            child: Consumer(
                              builder:(ctx,watch,child) {
                                final _theatersProvider = watch(theatersProvider);
                                return CustomChipsList(
                                  chipContents: _theatersProvider.selectedSeatNames,
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
                                );
                              },
                            ),
                          ),

                          //Purchase seats button
                          const PurchaseSeatsButton(),

                          const SizedBox(height: 5),
                        ],
                      );
                    },
                    loading: () => const TheaterSkeletonLoader(),
                    error: (error, st) => _buildError(error, st, context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildError(error, StackTrace? st, BuildContext context) {
    if (error is NetworkException) {
      return CustomErrorWidget.dark(
        error: error,
        retryCallback: () {
          context.refresh(showSeatingFuture);
        },
        height: context.screenHeight * 0.5,
      );
    }
    debugPrint(error.toString());
    debugPrint(st.toString());
    return const SizedBox.shrink();
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
          decoration: BoxDecoration(
            color: Colors.white30,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Icon(Icons.arrow_back_rounded, size: 23),
          ),
        ),
      ),
    );
  }
}
