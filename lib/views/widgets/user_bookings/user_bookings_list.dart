import 'package:flutter/material.dart';

//Helpers
import '../../../helper/utils/constants.dart';

//Models
import '../../../models/user_booking_model.dart';

//Skeletons
import '../../skeletons/movie_poster_placeholder.dart';

//Widgets
import '../common/custom_network_image.dart';
import 'booking_details_dialog.dart';
import 'booking_summary_row.dart';

class UserBookingsList extends StatelessWidget {
  const UserBookingsList({
    Key? key,
    required this.bookings,
  }) : super(key: key);

  static const movieSize = 100.0;
  final List<UserBookingModel> bookings;

  void onTap(BuildContext context, UserBookingModel booking) {
    showGeneralDialog(
      barrierColor: Constants.barrierColorLight,
      transitionDuration: const Duration(milliseconds: 400),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      transitionBuilder: (context, a1, a2, dialog) {
        final curveValue =
            (1 - Curves.linearToEaseOut.transform(a1.value)) * 200;
        return Transform(
          transform: Matrix4.translationValues(curveValue, 0.0, 0.0),
          child: Opacity(opacity: a1.value, child: dialog),
        );
      },
      pageBuilder: (_, __, ___) => BookingDetailsDialog(
        posterUrl: booking.posterUrl,
        bookings: booking.bookings,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: bookings.length,
      separatorBuilder: (_, i) => const SizedBox(height: 20),
      itemBuilder: (_, i) {
        final booking = bookings[i];
        final total = booking.bookings.fold(0.0, (sum, seat) => seat.price);
        final noOfSeats = booking.bookings.length;
        return SizedBox(
          height: 140,
          child: GestureDetector(
            onTap: () => onTap(context,booking),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                //Booking overview
                BookingSummaryRow(
                  total: total,
                  noOfSeats: noOfSeats,
                  title: booking.title,
                  showDateTime: booking.show.showDatetime,
                  showType: booking.show.showType,
                ),

                //Movie Image
                Positioned(
                  bottom: 13,
                  left: 13,
                  child: CustomNetworkImage(
                    imageUrl: booking.posterUrl,
                    fit: BoxFit.cover,
                    width: movieSize,
                    height: movieSize + 25,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    placeholder: const MoviePosterPlaceholder(iconSize: 40),
                    errorWidget: const MoviePosterPlaceholder(iconSize: 40),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
