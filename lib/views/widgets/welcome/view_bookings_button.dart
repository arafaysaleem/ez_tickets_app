import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

//Helpers
import '../../../helper/utils/constants.dart';

//Routes
import '../../../routes/app_router.gr.dart';

//Widgets
import '../common/custom_text_button.dart';

class ViewBookingsButton extends StatelessWidget {
  const ViewBookingsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextButton.outlined(
      width: double.infinity,
      onPressed: () => context.router.push(const UserBookingsScreenRoute()),
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

