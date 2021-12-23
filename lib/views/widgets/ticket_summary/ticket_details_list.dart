import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../helper/utils/constants.dart';

//Providers
import '../../../providers/all_providers.dart';

//Widgets
import 'dashed_ticket_separator.dart';

class TicketDetailsList extends HookConsumerWidget {
  const TicketDetailsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _theaterProvider = ref.watch(theatersProvider);
    final selectedSeats = _theaterProvider.selectedSeats;
    final selectedSeatName = _theaterProvider.selectedSeatNames;
    return ListView.separated(
      itemCount: selectedSeats.length,
      separatorBuilder: (_, i) => const DashedTicketSeparator(),
      itemBuilder: (_, i) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Seat icon
            const Icon(
              Icons.event_seat_sharp,
              color: Constants.primaryColor,
            ),

            //Seat
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Seat',
                  style: TextStyle(
                    fontSize: 13,
                    color: Constants.textGreyColor,
                  ),
                ),
                Text(
                  selectedSeatName[i],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            //Price
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Price',
                  style: TextStyle(
                    fontSize: 13,
                    color: Constants.textGreyColor,
                  ),
                ),
                Text(
                  'Rs. ${Constants.ticketPrice}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
