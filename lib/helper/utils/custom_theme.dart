import 'package:flutter/material.dart';

import 'constants.dart';

class CustomTheme {
  static ThemeData get mainTheme {
    return ThemeData(
      primaryColor: Constants.primaryColor,
      scaffoldBackgroundColor: Constants.scaffoldColor,
      fontFamily: Constants.latoFont.fontFamily,
      textTheme: TextTheme(
        headline1: Constants.latoFont.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
        headline2: Constants.latoFont.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 26,
        ),
        headline3: Constants.latoFont.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 22,
        ),
        headline4: Constants.latoFont.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 18,
        ),
        headline5: Constants.latoFont.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
        headline6: Constants.latoFont.copyWith(
          fontWeight: FontWeight.w400,
        ),
        bodyText1: Constants.poppinsFont.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
        bodyText2: Constants.poppinsFont.copyWith(
          fontWeight: FontWeight.w300,
        ),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        buttonColor: Constants.buttonGreyColor,
      ),
    );
  }
}
