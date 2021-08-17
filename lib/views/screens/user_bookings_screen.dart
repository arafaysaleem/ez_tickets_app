import 'package:flutter/material.dart';

//Helpers
import '../../helper/extensions/context_extensions.dart';

//Routing
import '../../routes/app_router.dart';

//Widgets
import '../widgets/user_bookings/user_bookings_history.dart';

class UserBookingsScreen extends StatelessWidget {
  const UserBookingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            //Back and title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 15),
                InkResponse(
                  radius: 25,
                  child: const Icon(Icons.arrow_back_sharp, size: 26),
                  onTap: () {
                    AppRouter.pop();
                  },
                ),

                const SizedBox(width: 20),

                //Page Title
                Expanded(
                  child: Text(
                    'Your bookings',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: context.headline3.copyWith(fontSize: 22),
                  ),
                ),

                const SizedBox(width: 50),
              ],
            ),

            const SizedBox(height: 20),

            //Bookings history
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: UserBookingsHistory(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
