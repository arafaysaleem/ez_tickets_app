import 'package:flutter/material.dart';

//Helpers
import '../../helper/extensions/context_extensions.dart';

//Routing
import '../../routes/app_router.dart';

//Widgets
import '../widgets/ticket_summary/confirm_bookings_button.dart';
import '../widgets/ticket_summary/tickets_summary_box.dart';

class TicketSummaryScreen extends StatelessWidget {
  const TicketSummaryScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: const [
            SizedBox(height: 20),

            //Back icon and title
            _BackIconRow(),

            SizedBox(height: 20),

            //Tickets Box
            TicketsSummaryBox(),

            //Confirm Button
            ConfirmBookingsButton(),

            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

class _BackIconRow extends StatelessWidget {
  const _BackIconRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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

        const SizedBox(width: 85),

        //Title
        Text(
          'Your tickets',
          style: context
              .headline5
              .copyWith(fontSize: 20),
        ),

        const Spacer(),
      ],
    );
  }
}

