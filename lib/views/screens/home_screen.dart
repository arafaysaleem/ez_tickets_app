import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import '../widgets/custom_text_button.dart';

import '../../helper/utils/constants.dart';
import '../../helper/utils/assets_helper.dart';

import '../../routes/app_router.gr.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(
          20,
          125,
          20,
          Constants.bottomInsets(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Heading text
            Text(
              "EZ Tickets",
              style: textTheme.headline1!.copyWith(
                color: theme.primaryColor,
              ),
            ),

            const SizedBox(height: 35),

            //Welcome msg
            Text(
              "Welcome to\nthe new\nNueplex cinemas",
              style: textTheme.headline3!,
            ),

            const SizedBox(height: 40),

            //experience msg
            Text(
              "New level of features\nwith the new app",
              style: textTheme.headline5!.copyWith(
                color: Constants.textGreyColor,
                fontWeight: FontWeight.w400,
                fontSize: 21,
              ),
            ),

            const Spacer(),

            //Login row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Login button
                Expanded(
                  child: CustomTextButton.gradient(
                    width: double.infinity,
                    onPressed: () {
                      AutoRouter.of(context).push(LoginScreenRoute());
                    },
                    gradient: Constants.buttonGradientRed,
                    child: const Center(
                      child: const Text(
                        "LOGIN",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          letterSpacing: 0.7,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                //face id
                CustomTextButton.gradient(
                  width: 60,
                  onPressed: () {},
                  gradient: Constants.buttonGradientRed,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(AssetsHelper.faceId),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 17),

            //Register button
            CustomTextButton.outlined(
              width: double.infinity,
              onPressed: () {
                AutoRouter.of(context).push(RegisterScreenRoute());
              },
              border: Border.all(color: theme.primaryColor, width: 4),
              child: Center(
                child: Text(
                  "REGISTER",
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontSize: 15,
                    letterSpacing: 0.7,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
