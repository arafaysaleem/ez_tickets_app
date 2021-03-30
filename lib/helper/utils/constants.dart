import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  static Color get primaryColor => Color(0xFFf03400);

  static Color get redColor => Color(0xFFed0000);

  static Color get orangeColor => Color(0xFFf04f00);

  static Color get starsColor => Color(0xFFf76540);

  static Gradient get buttonGradientRed =>
      LinearGradient(colors: [primaryColor, redColor]);

  static Gradient get buttonGradientOrange =>
      LinearGradient(colors: [orangeColor, redColor]);

  static Color get buttonGreyColor => Color(0xFF1c1c1c);

  static Color get scaffoldColor => Color(0xFF141414);

  static Color get scaffoldGreyColor => Color(0xFF2b2b2b);

  static Color get textGreyColor => Color(0xFF949494);

  static Color get textWhite80Color => Color(0xFFf2f2f2);

  static TextStyle get latoFont =>
      GoogleFonts.lato().copyWith(color: Colors.black);

  static TextStyle get poppinsFont =>
      GoogleFonts.poppins().copyWith(color: textWhite80Color);

  static TextStyle get robotoFont => GoogleFonts.roboto();

  static Duration get defaultAnimationDuration => Duration(milliseconds: 550);

  static double get bottomInsets => 65;
}
