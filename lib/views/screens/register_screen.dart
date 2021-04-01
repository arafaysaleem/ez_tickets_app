import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../helper/utils/constants.dart';
import '../widgets/common/custom_text_button.dart';
import '../widgets/common/custom_textfield.dart';
import '../widgets/common/rounded_bottom_container.dart';
import '../widgets/common/scrollable_column.dart';

class RegisterScreen extends StatefulHookWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isState1 = true;

  List<Widget> getState1Fields() {
    return [
      //Full name
      const CustomTextField(
        floatingText: "Full name",
        hintText: "Type your full name",
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
      ),

      const SizedBox(height: 25),

      //Email
      const CustomTextField(
        floatingText: "Email",
        hintText: "Type your email address",
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
      ),

      const SizedBox(height: 25),

      //Address
      const CustomTextField(
        floatingText: "Address",
        hintText: "Type your full address",
        keyboardType: TextInputType.streetAddress,
        textInputAction: TextInputAction.next,
      ),

      const SizedBox(height: 25),

      //Contact
      const CustomTextField(
        floatingText: "Contact",
        hintText: "Type your contact number",
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.done,
      ),
    ];
  }

  List<Widget> getState2Fields() {
    return [
      //Password
      const CustomTextField(
        floatingText: "Password",
        hintText: "Type your password",
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.next,
      ),

      const SizedBox(height: 25),

      //Confirm Password
      const CustomTextField(
        floatingText: "Confirm Password",
        hintText: "Retype your password",
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ScrollableColumn(
          children: [
            //Input card
            RoundedBottomContainer(
              children: [
                //Page name
                Text(
                  "Register",
                  style: textTheme.headline3!.copyWith(
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),

                const SizedBox(height: 20),

                if (isState1) ...getState1Fields() else ...getState2Fields(),
              ],
            ),

            const Spacer(),

            Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                40,
                20,
                Constants.bottomInsets,
              ),
              child: AnimatedSwitcher(
                duration: Constants.defaultAnimationDuration,
                switchOutCurve: Curves.easeInBack,
                child: isState1

                    //Next Button
                    ? CustomTextButton.outlined(
                        width: double.infinity,
                        onPressed: () {
                          setState(() {
                            isState1 = false;
                          });
                        },
                        padding: const EdgeInsets.only(left: 20, right: 15),
                        border: Border.all(color: theme.primaryColor, width: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Next",
                              style: TextStyle(
                                color: theme.primaryColor,
                                fontSize: 15,
                                letterSpacing: 0.7,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            //Arrow
                            Icon(
                              Icons.arrow_forward_sharp,
                              size: 26,
                              color: theme.primaryColor,
                            )
                          ],
                        ),
                      )

                    //Confirm button
                    : CustomTextButton.gradient(
                        width: double.infinity,
                        onPressed: () {
                          setState(() {
                            isState1 = true;
                          });
                        },
                        gradient: Constants.buttonGradientOrange,
                        child: const Center(
                          child: const Text(
                            "CONFIRM",
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
            )
          ],
        ),
      ),
    );
  }
}
