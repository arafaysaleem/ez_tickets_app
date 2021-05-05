import 'package:flutter/material.dart';

import 'constants.dart';

@immutable
class CustomTheme {
  static ThemeData get mainTheme {
    return ThemeData(
      primaryColor: Constants.primaryColor,
      scaffoldBackgroundColor: Constants.scaffoldColor,
      fontFamily: Constants.poppinsFont.fontFamily,
      textTheme: TextTheme(
        headline1: Constants.poppinsFont.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 50,
          height: 1.15,
        ),
        headline2: Constants.latoFont.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 50,
          height: 1.15,
        ),
        headline3: Constants.poppinsFont.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 26,
          height: 1.15,
        ),
        headline4: Constants.latoFont.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 26,
          height: 1.15,
        ),
        headline5: Constants.poppinsFont.copyWith(
          fontWeight: FontWeight.w300,
          fontSize: 20,
          height: 1.15,
        ),
        headline6: Constants.latoFont.copyWith(
          fontWeight: FontWeight.w300,
          fontSize: 20,
          height: 1.15,
        ),
        subtitle1: Constants.poppinsFont.copyWith(
          fontWeight: FontWeight.w200,
        ),
        subtitle2: Constants.latoFont.copyWith(
          fontWeight: FontWeight.w200,
        ),
        bodyText1: Constants.poppinsFont.copyWith(
          fontWeight: FontWeight.w400,
        ),
        bodyText2: Constants.latoFont.copyWith(
          fontWeight: FontWeight.w400,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }
}
