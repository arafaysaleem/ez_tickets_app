import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../helper/extensions/context_extensions.dart';
import '../../helper/utils/constants.dart';
import '../../providers/all_providers.dart';

//Providers
import '../../providers/theaters_provider.dart';

//Routing
import '../../routes/app_router.dart';

//Skeletons
import '../skeletons/theater_skeleton_loader.dart';

//Widgets
import '../widgets/common/custom_chips_list.dart';
import '../widgets/common/error_response_handler.dart';
import '../widgets/theater/curved_screen.dart';
import '../widgets/theater/purchase_seats_button.dart';
import '../widgets/theater/seat_color_indicators.dart';
import '../widgets/theater/seats_area.dart';

class TheaterScreen extends HookConsumerWidget {
  const TheaterScreen();

  static const _seatSize = 28.0;
  static const _seatGap = 7.0;

  double getMaxGridHeight(int numOfRows) {
    return _seatSize * (14) + _seatGap + 3;
  }

  double getMaxScreenWidth(int seatsPerRow) {
    return seatsPerRow * (_seatSize + _seatGap + 3);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showSeatingModelFuture = ref.watch(showSeatingFuture);
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
                      var screenWidth = getMaxScreenWidth(theater.seatsPerRow);
                      screenWidth = max(screenWidth, minScreenWidth);
                      final maxGridHeight = getMaxGridHeight(theater.numOfRows);
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
                            maxGridHeight: maxGridHeight,
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
                              builder: (ctx, ref, child) {
                                final _theatersProvider =
                                    ref.watch(theatersProvider);
                                return CustomChipsList(
                                  chipContents:
                                      _theatersProvider.selectedSeatNames,
                                  chipHeight: 27,
                                  chipGap: 10,
                                  fontSize: 14,
                                  chipWidth: 60,
                                  borderColor: Constants.orangeColor,
                                  contentColor: Constants.orangeColor,
                                  borderWidth: 1.5,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor:
                                      Colors.red.shade700.withOpacity(0.3),
                                  isScrollable: true,
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
                    error: (error, st) => ErrorResponseHandler(
                      error: error,
                      retryCallback: () => ref.refresh(showSeatingFuture),
                      stackTrace: st,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackIcon extends ConsumerWidget {
  const _BackIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: InkResponse(
        radius: 25,
        onTap: () {
          ref.read(theatersProvider).clearSelectedSeats();
          AppRouter.pop();
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
