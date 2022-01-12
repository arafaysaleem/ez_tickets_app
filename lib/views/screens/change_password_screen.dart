import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../helper/extensions/context_extensions.dart';
import '../../helper/utils/constants.dart';

//Providers
import '../../providers/all_providers.dart';
import '../../providers/auth_provider.dart';

//States
import '../../providers/states/future_state.dart';

//Routing
import '../../routes/app_router.dart';
import '../widgets/change_password/change_password_fields.dart';
import '../widgets/change_password/save_password_button.dart';

//Widgets
import '../widgets/common/custom_dialog.dart';
import '../widgets/common/rounded_bottom_container.dart';
import '../widgets/common/scrollable_column.dart';

class ChangePasswordScreen extends HookConsumerWidget {
  const ChangePasswordScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPasswordController = useTextEditingController();
    final newPasswordController = useTextEditingController();
    final cNewPasswordController = useTextEditingController();
    late final _formKey = useMemoized(() => GlobalKey<FormState>());
    ref.listen<FutureState<String>>(
      changePasswordStateProvider,
      (previous, changePasswordState) async {
        changePasswordState.maybeWhen(
          data: (message) async {
            currentPasswordController.clear();
            newPasswordController.clear();
            cNewPasswordController.clear();
            await showDialog<bool>(
              context: context,
              barrierColor: Constants.barrierColor.withOpacity(0.75),
              builder: (ctx) => CustomDialog.alert(
                title: 'Change Password Success',
                body: message,
                buttonText: 'Okay',
                onButtonPressed: () => AppRouter.pop(),
              ),
            );
          },
          failed: (reason) async => await showDialog<bool>(
            context: context,
            barrierColor: Constants.barrierColor.withOpacity(0.75),
            builder: (ctx) => CustomDialog.alert(
              title: 'Change Password Failed',
              body: reason,
              buttonText: 'Retry',
            ),
          ),
          orElse: () {},
        );
      },
    );
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ScrollableColumn(
          children: [
            //Input card
            Form(
              key: _formKey,
              child: RoundedBottomContainer(
                children: [
                  //Page name
                  Text(
                    'Change password',
                    textAlign: TextAlign.center,
                    style: context.headline3.copyWith(fontSize: 22),
                  ),

                  const SizedBox(height: 20),

                  //Password fields
                  ChangePasswordFields(
                    currentPasswordController: currentPasswordController,
                    newPasswordController: newPasswordController,
                    cNewPasswordController: cNewPasswordController,
                  ),
                ],
              ),
            ),

            const Spacer(),

            //Save Password Button
            Padding(
              padding:
                  const EdgeInsets.fromLTRB(20, 40, 20, Constants.bottomInsets),
              child: SavePasswordButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final _authProv = ref.read(authProvider.notifier);
                    _authProv.changePassword(
                      newPassword: newPasswordController.text,
                    );
                  }
                },
              ),
            ),

            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
