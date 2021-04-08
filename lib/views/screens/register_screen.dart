import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../helper/extensions/string_extension.dart';

//Helpers
import '../../helper/utils/constants.dart';

//Providers
import '../../providers/all_providers.dart';

//Widgets
import '../widgets/common/custom_text_button.dart';
import '../widgets/common/custom_textfield.dart';
import '../widgets/common/rounded_bottom_container.dart';
import '../widgets/common/scrollable_column.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isState1 = true;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: "");
  final passwordController = TextEditingController(text: "");
  final cPasswordController = TextEditingController(text: "");
  final fullNameController = TextEditingController(text: "");
  final addressController = TextEditingController(text: "");
  final contactController = TextEditingController(text: "");

  List<Widget> getState1Fields() {
    return [
      //Full name
      CustomTextField(
        controller: fullNameController,
        floatingText: "Full name",
        hintText: "Type your full name",
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        validator: (fullName) {
          if (fullName!.isEmpty) return "Please enter a full name";
          return null;
        },
      ),

      const SizedBox(height: 25),

      //Email
      CustomTextField(
        controller: emailController,
        floatingText: "Email",
        hintText: "Type your email address",
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        validator: (email) {
          if (email != null && email.isValidEmail) return null;
          return "Please enter a valid email address";
        },
      ),

      const SizedBox(height: 25),

      //Address
      CustomTextField(
        controller: addressController,
        floatingText: "Address",
        hintText: "Type your full address",
        keyboardType: TextInputType.streetAddress,
        textInputAction: TextInputAction.next,
        validator: (address) {
          if (address!.isEmpty) return "Please enter a address";
          return null;
        },
      ),

      const SizedBox(height: 25),

      //Contact
      CustomTextField(
        controller: contactController,
        floatingText: "Contact",
        hintText: "Type your contact number",
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.done,
        validator: (contact) {
          if (contact!.isEmpty) return "Please enter a contact";
          return null;
        },
      ),
    ];
  }

  List<Widget> getState2Fields() {
    return [
      //Password
      CustomTextField(
        controller: passwordController,
        floatingText: "Password",
        hintText: "Type your password",
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.next,
        validator: (password) {
          if (password!.isEmpty) return "Please enter a password";
          return null;
        },
      ),

      const SizedBox(height: 25),

      //Confirm Password
      CustomTextField(
        controller: cPasswordController,
        floatingText: "Confirm Password",
        hintText: "Retype your password",
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
        validator: (cPassword) {
          if (passwordController.text.trim() == cPassword) return null;
          return "Passwords don't match";
        },
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
            Form(
              key: formKey,
              child: RoundedBottomContainer(
                onBackTap: !isState1
                    ? () {
                        setState(() {
                          isState1 = true;
                        });
                      }
                    : null,
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
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              isState1 = false;
                            });
                          }
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
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            context.read(authProvider).register(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  fullName: fullNameController.text,
                                  address: addressController.text,
                                  contact: contactController.text,
                                );
                          }
                          // setState(() {
                          //   isState1 = true;
                          // });
                        },
                        gradient: Constants.buttonGradientOrange,
                        child: const Center(
                          child: Text(
                            "CONFIRM",
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
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    cPasswordController.dispose();
    fullNameController.dispose();
    addressController.dispose();
    contactController.dispose();
    super.dispose();
  }
}
