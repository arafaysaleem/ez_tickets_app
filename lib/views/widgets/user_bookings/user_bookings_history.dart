import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Providers
import '../../../providers/bookings_provider.dart';

//Skeletons
import '../../skeletons/user_bookings_skeleton_loader.dart';

//Widgets
import '../common/error_response_handler.dart';
import 'user_bookings_list.dart';

class UserBookingsHistory extends HookWidget {
  const UserBookingsHistory();

  @override
  Widget build(BuildContext context) {
    final userBookingsFuture = useProvider(userBookingsProvider);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      switchOutCurve: Curves.easeInBack,
      child: userBookingsFuture.when(
        data: (bookings) => UserBookingsList(bookings: bookings),
        loading: () => const UserBookingsSkeletonLoader(),
        error: (error, st) => ErrorResponseHandler(
          error: error,
          retryCallback: () => context.refresh(userBookingsProvider),
          stackTrace: st,
        ),
      ),
    );
  }
}
