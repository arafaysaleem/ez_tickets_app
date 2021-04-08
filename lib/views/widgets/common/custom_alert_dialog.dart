import 'package:flutter/material.dart';

import '../../../helper/utils/constants.dart';

import 'custom_text_button.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 19),
      titlePadding: const EdgeInsets.fromLTRB(17, 13, 17, 0),
      contentPadding: const EdgeInsets.fromLTRB(17, 9, 17, 9),
      actionsPadding: const EdgeInsets.fromLTRB(0,0,7,7),
      backgroundColor: Constants.scaffoldGreyColor,
      content: const Text(
        "Do you want to go back without saving your form data?",
      ),
      contentTextStyle: textTheme.bodyText1!.copyWith(
        color: Constants.textGreyColor,
        fontSize: 16,
      ),
      title: const Text("Are you sure?"),
      titleTextStyle: textTheme.bodyText1!.copyWith(
        color: Constants.textWhite80Color,
        fontSize: 19,
      ),
      actions: <Widget>[
        CustomTextButton.outlined(
          child: Center(
            child: Text(
              "Yes",
              style: TextStyle(color: Constants.primaryColor),
            ),
          ),
          border: Border.all(color: Constants.primaryColor),
          height: 40,
          width: 60,
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        CustomTextButton.gradient(
          gradient: Constants.buttonGradientRed,
          child: const Center(
            child: Text(
              "No",
              style: TextStyle(color: Colors.white),
            ),
          ),
          height: 40,
          width: 60,
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        )
      ],
    );
  }
}

