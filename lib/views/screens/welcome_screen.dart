import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../helper/extensions/context_extensions.dart';
import '../../helper/utils/constants.dart';

//Providers
import '../../providers/all_providers.dart';

//Routing
import '../../routes/routes.dart';
import '../../routes/app_router.dart';

//Widgets
import '../widgets/welcome/user_profile_details.dart';
import '../widgets/welcome/view_bookings_button.dart';
import '../widgets/welcome/browse_movies_button.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 65),

            //Logout
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Log out icon
                RotatedBox(
                  quarterTurns: 2,
                  child: InkResponse(
                    radius: 26,
                    child: const Icon(
                      Icons.logout,
                      color: Constants.primaryColor,
                      size: 30,
                    ),
                    onTap: () {
                      ref.read(authProvider.notifier).logout();
                      AppRouter.popUntilRoot();
                    },
                  ),
                ),

                //Edit profile icon
                InkResponse(
                  radius: 26,
                  child: const Icon(
                    Icons.manage_accounts_sharp,
                    color: Constants.primaryColor,
                    size: 30,
                  ),
                  onTap: () {
                    AppRouter.pushNamed(Routes.ChangePasswordScreenRoute);
                  },
                )
              ],
            ),

            const SizedBox(height: 20),

            //Welcome
            Text(
              'Welcome',
              style: context.headline1.copyWith(
                color: Constants.primaryColor,
                fontSize: 45,
              ),
            ),

            const SizedBox(height: 50),

            //User Details
            const Flexible(
              child: SizedBox(
                width: double.infinity,
                child: UserProfileDetails(),
              ),
            ),

            const SizedBox(height: 60),

            //Booking History Button
            const ViewBookingsButton(),

            const SizedBox(height: 20),

            //Browse Movies Button
            const BrowseMoviesButton(),

            const SizedBox(height: Constants.bottomInsetsLow + 5),
          ],
        ),
      ),
    );
  }
}


