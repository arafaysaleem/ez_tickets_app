import 'package:flutter/material.dart';

//Helpers
import '../../../helper/utils/constants.dart';

//Routing
import '../../../routes/routes.dart';
import '../../../routes/app_router.dart';

//Widgets
import '../common/custom_text_button.dart';

class ViewBookingsButton extends StatelessWidget {
  const ViewBookingsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextButton.outlined(
      width: double.infinity,
      onPressed: () => AppRouter.pushNamed(Routes.UserBookingsScreenRoute),
      border: Border.all(color: Constants.primaryColor,width: 4),
      child: const Center(
        child: Text(
          'VIEW BOOKINGS',
          style: TextStyle(
            color: Constants.primaryColor,
            fontSize: 15,
            letterSpacing: 0.7,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

