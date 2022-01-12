import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Providers
import '../../../providers/bookings_provider.dart';

//Skeletons
import '../../skeletons/user_bookings_skeleton_loader.dart';

//Widgets
import '../common/error_response_handler.dart';
import 'user_bookings_list.dart';

class UserBookingsHistory extends HookConsumerWidget {
  const UserBookingsHistory();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userBookingsFuture = ref.watch(userBookingsProvider);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      switchOutCurve: Curves.easeInBack,
      child: userBookingsFuture.when(
        data: (bookings) => UserBookingsList(bookings: bookings),
        loading: () => const UserBookingsSkeletonLoader(),
        error: (error, st) => ErrorResponseHandler(
          error: error,
          retryCallback: () => ref.refresh(userBookingsProvider),
          stackTrace: st,
        ),
      ),
    );
  }
}
