import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../helper/extensions/string_extension.dart';
import '../../helper/utils/constants.dart';

//Providers
import '../../providers/all_providers.dart';

//States
import '../../providers/states/auth_state.dart';

//Widgets
import '../widgets/common/custom_dialog.dart';
import '../widgets/common/custom_text_button.dart';
import '../widgets/common/custom_textfield.dart';
import '../widgets/common/rounded_bottom_container.dart';
import '../widgets/common/scrollable_column.dart';

class LoginScreen extends HookWidget {
  const LoginScreen();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = useTextEditingController(text: "");
    final passwordController = useTextEditingController(text: "");
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      body: ProviderListener(
        provider: authProvider,
        onChange: (context, authState) async {
          if (authState is AUTHENTICATED) {
            emailController.clear();
            passwordController.clear();
            context.router.popUntilRoot();
          } else if (authState is FAILED) {
            await showDialog<bool>(
              context: context,
              barrierColor: Constants.barrierColor.withOpacity(0.75),
              builder: (ctx) => CustomDialog.alert(
                title: "Login Failed",
                body: authState.reason,
                buttonText: "Retry",
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
                  ],
                ),
              ),

              const Spacer(),

              //Login button
              Padding(
                padding: const EdgeInsets.fromLTRB(
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
                  child: Consumer(
                    builder: (context, watch, child) {
                      final authState = watch(authProvider);
                      if (authState is AUTHENTICATING) {
                        return const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        );
                      }
                      return child!;
                    },
                    child: const Center(
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
        ),
      ),
    );
  }
}
