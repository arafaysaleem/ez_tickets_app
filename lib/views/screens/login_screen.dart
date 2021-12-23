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
import '../../routes/app_router.dart';

//Routing
import '../../routes/routes.dart';

//Widgets
import '../widgets/common/custom_dialog.dart';
import '../widgets/common/custom_text_button.dart';
import '../widgets/common/custom_textfield.dart';
import '../widgets/common/rounded_bottom_container.dart';
import '../widgets/common/scrollable_column.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    ref.listen<AuthState>(
      authProvider,
      (_, authState) => authState.maybeWhen(
        authenticated: (_) {
          emailController.clear();
          passwordController.clear();
          AppRouter.popUntilRoot();
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
    );
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ScrollableColumn(
          children: [
            //Input card
            Form(
              key: formKey,
              child: RoundedBottomContainer(
                padding: const EdgeInsets.fromLTRB(25.0, 28, 25.0, 20),
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

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    AppRouter.pushNamed(Routes.ForgotPasswordScreenRoute);
                  },
                  child: Text(
                    'Forgot your password?',
                    style: context.headline3.copyWith(
                      fontSize: 17,
                      color: Constants.primaryColor,
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),

            //Login button
            Padding(
              padding:
                  const EdgeInsets.fromLTRB(20, 40, 20, Constants.bottomInsets),
              child: CustomTextButton.gradient(
                width: double.infinity,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    ref.read(authProvider.notifier).login(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                  }
                },
                gradient: Constants.buttonGradientOrange,
                child: Consumer(
                  builder: (context, ref, child) {
                    final authState = ref.watch(authProvider);
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
    );
  }
}
