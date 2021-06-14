import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../helper/extensions/context_extensions.dart';
import '../../../helper/utils/constants.dart';

//Providers
import '../../../providers/bookings_provider.dart';

//Services
import '../../../services/networking/network_exception.dart';

//Skeletons
import '../../skeletons/movie_poster_placeholder.dart';
import '../common/custom_error_widget.dart';

//Widgets
import '../common/custom_network_image.dart';

class UserBookingsList extends HookWidget {
  const UserBookingsList();

  static const movieSize = 100.0;
  static const padding = 15.0;

  @override
  Widget build(BuildContext context) {
    final userBookingsFuture = useProvider(userBookingsProvider);
    return userBookingsFuture.when(
      data: (bookings) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: bookings.length,
        separatorBuilder: (_, i) => const SizedBox(height: 20),
        itemBuilder: (_, i) {
          final booking = bookings[i];
          final total = booking.bookings.fold(0.0, (sum, seat) => seat.price);
          final noOfSeats = booking.bookings.length;
          return SizedBox(
            height: 140,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: 100,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Constants.scaffoldGreyColor,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Ticket total and movie name
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            movieSize + 23,
                            10,
                            5,
                            padding,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Movie data
                              Text(
                                bookings[i].title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
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

                        SizedBox(
                          height: double.infinity,
                          width: 45,
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              color: Constants.darkSkeletonColor,
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
                  ),
                ),

                //Movie Image
                Positioned(
                  bottom: 13,
                  left: 13,
                  width: movieSize,
                  height: movieSize + 25,
                  child: CustomNetworkImage(
                    imageUrl: bookings[i].posterUrl,
                    height: 255,
                    fit: BoxFit.cover,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    placeholder: const MoviePosterPlaceholder(),
                    errorWidget: const MoviePosterPlaceholder(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      loading: () => const SpinKitRing(color: Colors.red),
      error: (error, st) {
        if (error is NetworkException) {
          return CustomErrorWidget.dark(
            error: error,
            retryCallback: () {
              context.refresh(userBookingsProvider);
            },
            height: context.screenHeight * 0.5,
          );
        }
        debugPrint(error.toString());
        debugPrint(st.toString());
        return const SizedBox.shrink();
      },
    );
  }
}
