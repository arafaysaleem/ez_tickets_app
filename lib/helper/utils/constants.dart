import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  static Color get primaryColor => Color(0xFFf03400);

  static Color get redColor => Color(0xFFed0000);

  static Color get orangeColor => Color(0xFFf04f00);

  static Color get starsColor => Color(0xFFf78040);

  static Gradient get buttonGradientRed =>
      LinearGradient(colors: [primaryColor, redColor]);

  static Gradient get buttonGradientOrange =>
      LinearGradient(colors: [orangeColor, redColor]);

  static Gradient get movieCarouselGradient => LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        stops: const [0.3, 0.6, 1],
        colors: [
          Colors.white.withOpacity(0.95),
          Colors.white70,
          Colors.transparent,
        ],
      );

  static Gradient get blackOverlayGradient => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: const [0.2, 0.5, 0.7, 1],
        colors: [
          Colors.black.withOpacity(0.6),
          Colors.black.withOpacity(0.45),
          Colors.black.withOpacity(0.3),
          Colors.transparent,
        ],
      );

  static Color get buttonGreyColor => Color(0xFF1c1c1c);

  static Color get scaffoldColor => Color(0xFF141414);

  static Color get scaffoldGreyColor => Color(0xFF2b2b2b);

  static Color get textGreyColor => Color(0xFF949494);

  static Color get textWhite80Color => Color(0xFFf2f2f2);

  static Color get barrierColor => Colors.black87;

  static TextStyle get latoFont =>
      GoogleFonts.lato().copyWith(color: Colors.black);

  static TextStyle get poppinsFont =>
      GoogleFonts.poppins().copyWith(color: textWhite80Color);

  static TextStyle get robotoFont => GoogleFonts.roboto();

  static Duration get defaultAnimationDuration => Duration(milliseconds: 550);

  static double get bottomInsets => 65;

  static double get bottomInsetsLow => 45;

  static RegExp get emailRegex => RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\.]+\.(com|pk)+");

  static RegExp get contactRegex => RegExp(r"^(03|3)\d{9}$");

  static RegExp get fullNameRegex => RegExp(r"^[a-zA-Z ]+$");

}
