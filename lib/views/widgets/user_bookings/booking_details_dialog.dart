import 'package:flutter/material.dart';

//Helpers
import '../../../enums/booking_status_enum.dart';
import '../../../helper/utils/constants.dart';

//Models
import '../../../models/booking_model.dart';

//Skeletons
import '../../skeletons/movie_poster_placeholder.dart';

//Widgets
import '../common/custom_network_image.dart';

class BookingDetailsDialog extends StatelessWidget {
  final String posterUrl;
  final List<BookingModel> bookings;

  const BookingDetailsDialog({
    Key? key,
    required this.posterUrl,
    required this.bookings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 400,
        width: 250,
        child: Column(
          children: [
            //Movie Image
            CustomNetworkImage(
              imageUrl: posterUrl,
              fit: BoxFit.cover,
              height: 120,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              placeholder: const MoviePosterPlaceholder(),
              errorWidget: const MoviePosterPlaceholder(),
            ),

            //Grey Container
            Expanded(
              child: Material(
                color: Constants.scaffoldColor,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 12, 15, 0),
                  child: Column(
                    children: [
                      //Column Labels
                      Row(
                        children:const [
                          //Seat label
                          SizedBox(
                            width: 50,
                            child: Text(
                              'Seat',
                              style: TextStyle(
                                color: Constants.textWhite80Color,
                              ),
                            ),
                          ),

                          //Price label
                          Expanded(
                            child: Text(
                              'Price',
                              style: TextStyle(
                                color: Constants.textWhite80Color,
                              ),
                            ),
                          ),

                          //Status label
                          SizedBox(
                            width: 100,
                            child: Text(
                              'Seat Status',
                              style: TextStyle(
                                color: Constants.textWhite80Color,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      //Column data
                      Expanded(
                        child: ListView.separated(
                          itemCount: bookings.length,
                          padding: const EdgeInsets.all(0),
                          separatorBuilder: (ctx, i) => const SizedBox(height: 20),
                          itemBuilder: (ctx, i) => _BookingSeatsListItem(
                            booking: bookings[i],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //Expand icon
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Constants.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: const Icon(
                Icons.expand_more_sharp,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BookingSeatsListItem extends StatelessWidget {
  const _BookingSeatsListItem({
    Key? key,
    required this.booking,
  }) : super(key: key);

  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //Seat Name
        SizedBox(
          width: 50,
          child: Text(
            '${booking.seatRow}-${booking.seatNumber}',
            style: const TextStyle(
              color: Constants.textGreyColor,
              fontSize: 13,
            ),
          ),
        ),

        //Seat Price
        Expanded(
          child: Text(
            "${booking.seatNumber == 3 ? "1000.0": booking.price}",
            style: const TextStyle(
              color: Constants.textGreyColor,
              fontSize: 13,
            ),
          ),
        ),

        //Seat Status
        SizedBox(
          width: 100,
          child: Row(
            children: [
              //Booking Status value
              Text(
                booking.bookingStatus.name,
                style: const TextStyle(
                  color: Constants.textGreyColor,
                  fontSize: 13,
                ),
              ),

              const Spacer(),

              //Booking Status icon
              if (booking.bookingStatus == BookingStatus.CANCELLED)
                const Icon(
                  Icons.cancel_sharp,
                  size: 16,
                  color: Colors.red,
                )
              else if (booking.bookingStatus == BookingStatus.RESERVED)
                const Icon(
                  Icons.watch_later_sharp,
                  size: 16,
                  color: Colors.amber,
                )
              else if (booking.bookingStatus == BookingStatus.CONFIRMED)
                  const Icon(
                    Icons.check_circle_sharp,
                    size: 16,
                    color: Color(0xFF64DD17),
                  ),
            ],
          ),
        )
      ],
    );
  }
}
