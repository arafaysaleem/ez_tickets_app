import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

//Helpers
import '../../helper/utils/constants.dart';

//Routes
import '../../routes/app_router.gr.dart';

import '../widgets/common/custom_text_button.dart';

class WelcomeScreen extends StatelessWidget {
  final String fullName;

  const WelcomeScreen({Key? key, required this.fullName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Welcome
          Text(
            "Welcome $fullName",
            style: textTheme.headline1!.copyWith(
              color: theme.primaryColor,
            ),
          ),

          const SizedBox(height: 20),

          //Continue Button
          CustomTextButton.gradient(
            width: double.infinity,
            onPressed: () {
              context.router.push(const MoviesScreenRoute());
            },
            gradient: Constants.buttonGradientOrange,
            child: const Center(
              child: Text(
                "CONTINUE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  letterSpacing: 0.7,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


