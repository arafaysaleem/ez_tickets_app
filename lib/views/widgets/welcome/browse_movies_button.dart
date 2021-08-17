import 'package:flutter/material.dart';

//Helpers
import '../../../helper/utils/constants.dart';

//Routing
import '../../../routes/routes.dart';
import '../../../routes/app_router.dart';

//Widgets
import '../common/custom_text_button.dart';

class BrowseMoviesButton extends StatelessWidget {
  const BrowseMoviesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextButton.gradient(
      width: double.infinity,
      onPressed: () {
        AppRouter.pushNamed(Routes.MoviesScreenRoute);
      },
      gradient: Constants.buttonGradientOrange,
      child: const Center(
        child: Text(
          'BROWSE MOVIES',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            letterSpacing: 0.7,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
