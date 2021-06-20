import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Helpers
import '../../helper/extensions/context_extensions.dart';
import '../../helper/utils/constants.dart';

//Providers
import '../../providers/all_providers.dart';
import '../../providers/states/future_state.dart';

//Widgets
import '../widgets/change_password/change_password_fields.dart';
import '../widgets/change_password/save_password_button.dart';
import '../widgets/common/custom_dialog.dart';
import '../widgets/common/scrollable_column.dart';

class ChangePasswordScreen extends HookWidget {
  const ChangePasswordScreen();

  @override
  Widget build(BuildContext context) {
    final currentPasswordController = useTextEditingController();
    final newPasswordController = useTextEditingController();
    final cNewPasswordController = useTextEditingController();
    late final _formKey = useMemoized(() => GlobalKey<FormState>());
    return Scaffold(
      body: ProviderListener(
        provider: authProvider,
        onChange: (_, changePasswordState) async {
          (changePasswordState as FutureState).maybeWhen(
            data: (message) async {
              currentPasswordController.clear();
              newPasswordController.clear();
              cNewPasswordController.clear();
              await showDialog<bool>(
                context: context,
                barrierColor: Constants.barrierColor.withOpacity(0.75),
                builder: (ctx) => CustomDialog.alert(
                  title: "Change Password Success",
                  body: message,
                  buttonText: "Okay",
                ),
              );
            },
            failed: (reason) async => await showDialog<bool>(
              context: context,
              barrierColor: Constants.barrierColor.withOpacity(0.75),
              builder: (ctx) => CustomDialog.alert(
                title: "Change Password Failed",
                body: reason,
                buttonText: "Retry",
              ),
            ),
            orElse: () {},
          );
        },
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
              key: _formKey,
              child: ScrollableColumn(
                children: [
                  const SizedBox(height: 20),

                  //Back and title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 15),

                      //Back icon
                      InkResponse(
                        radius: 25,
                        child: const Icon(Icons.arrow_back_sharp, size: 26),
                        onTap: () {
                          context.router.pop();
                        },
                      ),

                      const SizedBox(width: 20),

                      //Page Title
                      Expanded(
                        child: Text(
                          "Your profile",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: context.headline3.copyWith(fontSize: 22),
                        ),
                      ),

                      const SizedBox(width: 50),
                    ],
                  ),

                  const SizedBox(height: 20),

                  //Password fields
                  Flexible(
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ChangePasswordFields(
                          currentPasswordController: currentPasswordController,
                          newPasswordController: newPasswordController,
                          cNewPasswordController: cNewPasswordController,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),

                  //Save Password Button
                  SavePasswordButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final _authProv = context.read(authProvider.notifier);
                        _authProv.changePassword(
                          newPassword: newPasswordController.text,
                        );
                      }
                    },
                  ),

                  const SizedBox(height: Constants.bottomInsetsLow + 5),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
