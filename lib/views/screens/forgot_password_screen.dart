import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../helper/utils/constants.dart';

//Providers
import '../../providers/all_providers.dart';

//States
import '../../providers/states/forgot_password_state.dart';

//Routing
import '../../routes/app_router.dart';

//Widgets
import '../widgets/common/custom_dialog.dart';
import '../widgets/common/rounded_bottom_container.dart';
import '../widgets/common/scrollable_column.dart';
import '../widgets/forgot_password/forgot_button_widget.dart';
import '../widgets/forgot_password/forgot_message_widget.dart';
import '../widgets/forgot_password/forgot_name_widget.dart';
import '../widgets/forgot_password/forgot_resend_widget.dart';
import '../widgets/forgot_password/forgot_text_fields.dart';

class ForgotPasswordScreen extends HookConsumerWidget {
  const ForgotPasswordScreen();

  Future<bool> _showConfirmDialog(BuildContext context) async {
    final doPop = await showDialog<bool>(
      context: context,
      barrierColor: Constants.barrierColor,
      builder: (ctx) => const CustomDialog.confirm(
        title: 'Are you sure?',
        body: 'Do you want to go back without resetting your password?',
        trueButtonText: 'Yes',
        falseButtonText: 'No',
      ),
    );
    final popTheScreen = doPop != null && doPop;
    return Future<bool>.value(popTheScreen);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final emailController = useTextEditingController();
    late final newPasswordController = useTextEditingController();
    late final cNewPasswordController = useTextEditingController();
    late final _formKey = useMemoized(() => GlobalKey<FormState>());
    ref.listen<ForgotPasswordState>(
      forgotPasswordProvider,
      (_, forgotPwState) async => forgotPwState.maybeWhen(
        success: (_) async {
          emailController.clear();
          newPasswordController.clear();
          cNewPasswordController.clear();
          AppRouter.pop().then<bool?>((_) async {
            return await showDialog<bool>(
              context: context,
              barrierColor: Constants.barrierColor.withOpacity(0.75),
              builder: (ctx) => const CustomDialog.alert(
                title: 'Password Reset Successful',
                body: "In order to proceed, you'll have to login again with "
                    'your new password',
                buttonText: 'Okay',
              ),
            );
          });
        },
        failed: (reason, lastState) async => await showDialog<bool>(
          context: context,
          barrierColor: Constants.barrierColor.withOpacity(0.75),
          builder: (ctx) => CustomDialog.alert(
            title: 'Password Reset Failure',
            body: reason,
            buttonText: 'Retry',
            onButtonPressed: () {
              final forgotProv = ref.read(forgotPasswordProvider.notifier);
              forgotProv.retryForgotPassword(lastState);
            },
          ),
        ),
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
              key: _formKey,
              onWillPop: () => _showConfirmDialog(context),
              child: RoundedBottomContainer(
                padding: const EdgeInsets.fromLTRB(25.0, 28, 25.0, 20),
                children: [
                  //Relevant Page Name
                  const ForgotNameWidget(),

                  const SizedBox(height: 20),

                  //Relevant Input Fields
                  ForgotTextFields(
                    emailController: emailController,
                    newPasswordController: newPasswordController,
                    cNewPasswordController: cNewPasswordController,
                  ),

                  const SizedBox(height: 10),

                  //Resend message
                  const ForgotResendWidget(),
                ],
              ),
            ),

            const SizedBox(height: 20),

            //Relevant Response Message
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: ForgotMessageWidget(),
            ),

            const Spacer(),

            //Reset Password Button
            ForgotButtonWidget(
              emailController: emailController,
              newPasswordController: newPasswordController,
              formKey: _formKey,
            ),
          ],
        ),
      ),
    );
  }
}
