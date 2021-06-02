import 'package:flutter/material.dart';

extension ContextUtils on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  TextStyle get headline1 => textTheme.headline1!;
  TextStyle get headline2 => textTheme.headline2!;
  TextStyle get headline3 => textTheme.headline3!;
  TextStyle get headline4 => textTheme.headline4!;
  TextStyle get headline5 => textTheme.headline5!;
  TextStyle get headline6 => textTheme.headline6!;
  TextStyle get bodyText1 => textTheme.bodyText1!;
  TextStyle get bodyText2 => textTheme.bodyText2!;
}
