import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../helper/extensions/string_extension.dart';
import '../../helper/utils/constants.dart';

//Providers
import '../../providers/all_providers.dart';

//States
import '../../states/auth_state.dart';

//Widgets
import '../widgets/common/custom_text_button.dart';
import '../widgets/common/custom_textfield.dart';
import '../widgets/common/welcome_widget.dart';
import '../widgets/common/rounded_bottom_container.dart';
import '../widgets/common/scrollable_column.dart';

class LoginScreen extends HookWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(text: "");
    final passwordController = useTextEditingController(text: "");
    final authStatus = useProvider(authProvider);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      body: authStatus.maybeWhen(
        authenticated: (fullName) {
          emailController.clear();
          passwordController.clear();
          return WelcomeWidget(fullName: fullName);
        },
        orElse: () => GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ScrollableColumn(
            children: [
              //Input card
              Form(
                key: formKey,
                child: RoundedBottomContainer(
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

                    //Password
                    CustomTextField(
                      controller: passwordController,
                      floatingText: "Password",
                      hintText: "Type your password",
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      validator: (password) {
                        if (password!.isEmpty) return "Please enter a password";
                        return null;
                      },
                    ),

                    //Failure reason
                    if(authStatus is FAILED) Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: Text(
                          authStatus.reason,
                          style: textTheme.bodyText1!.copyWith(
                            fontSize: 18,
                            color: Constants.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              //Login button
              Padding(
                padding: EdgeInsets.fromLTRB(
                  20,
                  40,
                  20,
                  Constants.bottomInsets,
                ),
                child: CustomTextButton.gradient(
                  width: double.infinity,
                  onPressed: () async {
                    print("ON_PRESSED");
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      context.read(authProvider.notifier).login(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    }
                  },
                  gradient: Constants.buttonGradientOrange,
                  child: authStatus.maybeWhen(
                    authenticating: () => const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    orElse: () => const Center(
                      child: Text(
                        "LOGIN",
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
        )
      ),
    );
  }
}
