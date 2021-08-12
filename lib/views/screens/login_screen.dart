import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../helper/extensions/context_extensions.dart';
import '../../helper/utils/constants.dart';
import '../../helper/utils/form_validator.dart';

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
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    return Scaffold(
      body: ProviderListener<AuthState>(
        provider: authProvider,
        onChange: (context, authState) async => authState.maybeWhen(
          authenticated: (_) {
            emailController.clear();
            passwordController.clear();
            context.router.popUntilRoot();
          },
          failed: (reason) async {
            await showDialog<bool>(
              context: context,
              barrierColor: Constants.barrierColor.withOpacity(0.75),
              builder: (ctx) => CustomDialog.alert(
                title: 'Login Failed',
                body: reason,
                buttonText: 'Retry',
              ),
            );
          },
          orElse: () {},
        ),
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
                      'Login',
                      style: context.headline3.copyWith(
                        color: Colors.white,
                        fontSize: 32,
                      ),
                    ),

                    const SizedBox(height: 20),

                    //Email
                    CustomTextField(
                      controller: emailController,
                      autofocus: true,
                      floatingText: 'Email',
                      hintText: 'Type your email address',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: FormValidator.emailValidator,
                    ),

                    const SizedBox(height: 25),

                    //Password
                    CustomTextField(
                      controller: passwordController,
                      floatingText: 'Password',
                      hintText: 'Type your password',
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      validator: FormValidator.passwordValidator,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(
                    fontSize: 17,
                    color: Constants.primaryColor,
                  ),
                ),
              ),

              const Spacer(),

              //Login button
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, Constants.bottomInsets),
                child: CustomTextButton.gradient(
                  width: double.infinity,
                  onPressed: () async {
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
                      return authState.maybeWhen(
                        authenticating: () => const Center(
                          child: SpinKitRing(
                            color: Colors.white,
                            size: 30,
                            lineWidth: 4,
                            duration: Duration(milliseconds: 1100),
                          ),
                        ),
                        orElse: () => child!,
                      );
                    },
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
