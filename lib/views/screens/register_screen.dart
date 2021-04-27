import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../helper/extensions/string_extension.dart';
import '../../helper/utils/assets_helper.dart';
import '../../helper/utils/constants.dart';

//Providers
import '../../providers/all_providers.dart';

//Routes
import '../../routes/app_router.gr.dart';

//States
import '../../states/auth_state.dart';

//Widgets
import '../widgets/common/custom_alert_dialog.dart';
import '../widgets/common/custom_text_button.dart';
import '../widgets/common/custom_textfield.dart';
import '../widgets/common/rounded_bottom_container.dart';
import '../widgets/common/scrollable_column.dart';

class RegisterScreen extends StatefulHookWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isState1 = true, _formHasData = false;
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
          if (fullName != null && fullName.isValidFullName) return null;
          return "Please enter a valid full name";
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
        hintText: "Type your mobile #",
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.done,
        prefix: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(17, 0, 5, 0),
              child: Image.asset(
                AssetsHelper.pkFlag,
                width: 25,
              ),
            ),
            Text(
              "+92",
              style: TextStyle(
                fontSize: 18,
                color: Constants.textWhite80Color,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: VerticalDivider(
                thickness: 1.1,
                color: Colors.white,
              ),
            )
          ],
        ),
        validator: (contact) {
          if (contact != null && contact.isValidContact) return null;
          return "Please enter a valid contact";
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

  CustomTextButton getButton(ThemeData theme) {
    //Next Button
    if (isState1) {
      return CustomTextButton.outlined(
        width: double.infinity,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            setState(() {
              isState1 = false;
            });
          }
        },
        padding: const EdgeInsets.only(left: 20, right: 15),
        border: Border.all(
          color: theme.primaryColor,
          width: 4,
        ),
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
      );
    }
    //Confirm button
    return CustomTextButton.gradient(
      width: double.infinity,
      onPressed: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          context.read(authProvider.notifier).register(
                email: emailController.text,
                password: passwordController.text,
                fullName: fullNameController.text,
                address: addressController.text,
                contact: contactController.text,
              );
        }
      },
      gradient: Constants.buttonGradientOrange,
      child: Consumer(
        builder: (context, watch, child) {
          final authState = watch(authProvider);
          if (authState is AUTHENTICATING) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          }
          return child!;
        },
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
    );
  }

  Future<bool> showConfirmDialog(BuildContext context) async {
    if (_formHasData) {
      final doPop = await showDialog<bool>(
        context: context,
        barrierColor: Constants.barrierColor,
        builder: (ctx) => const CustomAlertDialog(
          title: "Do you want to go back without saving your form data?",
          body: "Are you sure?",
        ),
      );
      if (doPop == null || !doPop) return Future<bool>.value(false);
    }
    return Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      body: ProviderListener(
        provider: authProvider,
        onChange: (context, AuthState authState) async {
          if (authState is AUTHENTICATED) {
            emailController.clear();
            passwordController.clear();
            fullNameController.clear();
            addressController.clear();
            cPasswordController.clear();
            contactController.clear();
            _formHasData = false;
            context.router.push(WelcomeScreenRoute());
          } else if (authState is FAILED) {
            await showDialog<bool>(
              context: context,
              barrierColor: Constants.barrierColor,
              builder: (ctx) => CustomAlertDialog(
                title: "Login Failed",
                body: authState.reason,
              ),
            );
          }
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ScrollableColumn(
            children: [
              //Input card
              Form(
                key: formKey,
                onChanged: () {
                  _formHasData = true;
                },
                onWillPop: () => showConfirmDialog(context),
                child: RoundedBottomContainer(
                  onBackTap: !isState1
                      ? () => setState(() {
                            isState1 = true;
                          })
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

                    if (isState1)
                      ...getState1Fields()
                    else
                      ...getState2Fields(),
                  ],
                ),
              ),

              const Spacer(),

              //Button
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
                  child: getButton(theme),
                ),
              )
            ],
          ),
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
