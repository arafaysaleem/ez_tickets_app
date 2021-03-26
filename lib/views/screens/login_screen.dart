import 'package:flutter/material.dart';

import '../../helper/utils/constants.dart';

import '../widgets/scrollable_column.dart';
import '../widgets/custom_text_button.dart';
import '../widgets/rounded_bottom_container.dart';
import '../widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ScrollableColumn(
          children: [
            //Input card
            RoundedBottomContainer(
              children: [
                //Page name
                Text(
                  "Login",
                  style: textTheme.headline3!.copyWith(
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),

                const SizedBox(height: 20),

                //Email
                const CustomTextField(
                  floatingText: "Email",
                  hintText: "Type your email address",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: 25),

                //Password
                const CustomTextField(
                  floatingText: "Password",
                  hintText: "Type your password",
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 80),
              child: CustomTextButton.gradient(
                width: double.infinity,
                onPressed: () {},
                gradient: Constants.buttonGradientOrange,
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
            )
          ],
        ),
      ),
    );
  }
}
