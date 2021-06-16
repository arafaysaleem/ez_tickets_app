import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../helper/extensions/context_extensions.dart';

//Providers
import '../../../providers/bookings_provider.dart';

//Services
import '../../../services/networking/network_exception.dart';

//Skeletons
import '../../skeletons/user_bookings_skeleton_loader.dart';

//Widgets
import '../common/custom_error_widget.dart';
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
        error: (error, st) {
          if (error is NetworkException) {
            return CustomErrorWidget.dark(
              error: error,
              retryCallback: () => context.refresh(userBookingsProvider),
              height: context.screenHeight * 0.5,
            );
          }
          debugPrint(error.toString());
          debugPrint(st.toString());
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
