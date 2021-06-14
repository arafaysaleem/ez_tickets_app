import 'package:flutter/material.dart';

//Models
import '../../../helper/utils/constants.dart';

//Helpers
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
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Constants.scaffoldColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
