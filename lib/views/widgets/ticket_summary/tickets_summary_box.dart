import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../helper/utils/constants.dart';
import '../../../helper/extensions/context_extensions.dart';

//Providers
import '../../../providers/movies_provider.dart';

//Widgets
import '../common/custom_network_image.dart';
import 'dashed_ticket_separator.dart';
import 'show_details_section.dart';
import 'ticket_details_list.dart';

//Skeletons
import '../../skeletons/movie_poster_placeholder.dart';

class TicketsSummaryBox extends StatelessWidget {
  const TicketsSummaryBox();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight * 0.72,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            //Movie Picture
            Consumer(
              builder: (ctx, ref, _) {
                final _selectedMovie = ref.watch(selectedMovieProvider);
                return CustomNetworkImage(
                  imageUrl: _selectedMovie.posterUrl,
                  height: 255,
                  fit: BoxFit.cover,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  placeholder: const MoviePosterPlaceholder(),
                  errorWidget: const MoviePosterPlaceholder(),
                );
              },
            ),

            //Show details
            const ShowDetailsSection(),

            //Separator
            const DashedTicketSeparator(),

            //Ticket details
            const Expanded(
              child: TicketDetailsList(),
            ),

            //Expand icon
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Constants.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
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
