import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

//Helpers
import '../../../helper/utils/constants.dart';

//Providers
import '../../../providers/theaters_provider.dart';
import '../../../providers/shows_provider.dart';

class ShowDetailsSection extends StatelessWidget {
  const ShowDetailsSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 15,
      ),
      child: Consumer(
        builder: (ctx, ref, child) {
          final _selectedShow = ref.watch(selectedShowProvider);
          final _selectedShowTime = ref.watch(selectedShowTimeProvider);
          final _theaterName = ref.watch(selectedTheaterNameProvider);
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Date
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Date',
                    style: TextStyle(
                      fontSize: 13,
                      color: Constants.textGreyColor,
                    ),
                  ),
                  Text(
                    DateFormat('E, d MMMM y').format(_selectedShow.date),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              //Time
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Time',
                    style: TextStyle(
                      fontSize: 13,
                      color: Constants.textGreyColor,
                    ),
                  ),
                  Text(
                    DateFormat.Hm().format(_selectedShowTime.startTime),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              //Theater
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Theater',
                    style: TextStyle(
                      fontSize: 13,
                      color: Constants.textGreyColor,
                    ),
                  ),
                  Text(
                    _theaterName,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
