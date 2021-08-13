import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

//Helpers
import '../../../helper/utils/constants.dart';
import '../../../helper/extensions/context_extensions.dart';

//Widgets
import 'custom_text_button.dart';

// ignore: constant_identifier_names
enum CustomDialogType { ALERT, CONFIRM, ABOUT, SIMPLE }

class CustomDialog extends StatelessWidget {
  final String title, body;
  final String? buttonText, falseButtonText, trueButtonText;
  final CustomDialogType _type;
  final VoidCallback? falseButtonPressed, trueButtonPressed;

  const CustomDialog._({
    this.buttonText,
    this.falseButtonText,
    this.trueButtonText,
    this.falseButtonPressed,
    this.trueButtonPressed,
    required this.title,
    required this.body,
    required CustomDialogType type,
  }) : _type = type;

  const factory CustomDialog.alert({
    required String title,
    required String body,
    required String buttonText,
    VoidCallback? onButtonPressed,
  }) = _CustomDialogWithAlert;

  const factory CustomDialog.confirm({
    required String title,
    required String body,
    required String falseButtonText,
    required String trueButtonText,
    VoidCallback? falseButtonPressed,
    VoidCallback? trueButtonPressed,
  }) = _CustomDialogWithConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 19),
      titlePadding: const EdgeInsets.fromLTRB(19, 14, 19, 0),
      contentPadding: const EdgeInsets.fromLTRB(19, 9, 19, 9),
      actionsPadding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
      backgroundColor: Constants.scaffoldGreyColor,
      title: Text(title),
      content: Text(body),
      contentTextStyle: context.bodyText1.copyWith(
        color: Constants.textGreyColor,
        fontSize: 16,
      ),
      titleTextStyle: context.bodyText1.copyWith(
        color: Constants.textWhite80Color,
        fontSize: 19,
      ),
      actions: <Widget>[
        if (_type == CustomDialogType.ALERT)
          CustomTextButton.gradient(
            gradient: Constants.buttonGradientRed,
            child: Center(
              child: Text(
                buttonText!,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            height: 40,
            width: 60,
            onPressed: () {
              if(trueButtonPressed != null) trueButtonPressed!();
              context.router.pop();
            },
          )
        else if (_type == CustomDialogType.CONFIRM) ...[
          CustomTextButton.outlined(
            child: Center(
              child: Text(
                trueButtonText!,
                style: const TextStyle(color: Constants.primaryColor),
              ),
            ),
            border: Border.all(color: Constants.primaryColor),
            height: 40,
            width: 60,
            onPressed: () {
              if(trueButtonPressed != null) trueButtonPressed!();
              context.router.pop(true);
            },
          ),
          CustomTextButton.gradient(
            gradient: Constants.buttonGradientRed,
            child: Center(
              child: Text(
                falseButtonText!,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            height: 40,
            width: 60,
            onPressed: () {
              if(falseButtonPressed != null) falseButtonPressed!();
              context.router.pop(false);
            },
          ),
        ]
      ],
    );
  }
}

class _CustomDialogWithAlert extends CustomDialog {
  const _CustomDialogWithAlert({
    required String title,
    required String body,
    required String buttonText,
    VoidCallback? onButtonPressed,
  }) : super._(
          title: title,
          body: body,
          buttonText: buttonText,
          trueButtonPressed: onButtonPressed,
          type: CustomDialogType.ALERT,
        );
}

class _CustomDialogWithConfirm extends CustomDialog {
  const _CustomDialogWithConfirm({
    required String title,
    required String body,
    required String falseButtonText,
    required String trueButtonText,
    VoidCallback? falseButtonPressed,
    VoidCallback? trueButtonPressed,
  }) : super._(
          title: title,
          body: body,
          falseButtonText: falseButtonText,
          trueButtonText: trueButtonText,
          falseButtonPressed: falseButtonPressed,
          trueButtonPressed: trueButtonPressed,
          type: CustomDialogType.CONFIRM,
        );
}
