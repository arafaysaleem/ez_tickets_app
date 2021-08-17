import 'package:flutter/material.dart';

import '../../helper/utils/assets_helper.dart';

//Helpers
import '../../helper/utils/constants.dart';
import '../../helper/extensions/context_extensions.dart';

//Routing
import '../../routes/routes.dart';
import '../../routes/app_router.dart';

//Widgets
import '../widgets/common/custom_text_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 125, 20, Constants.bottomInsets),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Heading text
            Text(
              'EZ Tickets',
              style: context.headline1.copyWith(color: Constants.primaryColor),
            ),

            const SizedBox(height: 35),

            //Welcome msg
            Text(
              'Welcome to\nthe new\nNueplex cinemas',
              style: context.headline3,
            ),

            const SizedBox(height: 40),

            //Experience msg
            Text(
              'New level of features\nwith the new app',
              style: context.headline5.copyWith(
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
                      AppRouter.pushNamed(Routes.LoginScreenRoute);
                    },
                    gradient: Constants.buttonGradientRed,
                    child: const Center(
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
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
                AppRouter.pushNamed(Routes.RegisterScreenRoute);
              },
              border: Border.all(color: Constants.primaryColor, width: 4),
              child: const Center(
                child: Text(
                  'REGISTER',
                  style: TextStyle(
                    color: Constants.primaryColor,
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
