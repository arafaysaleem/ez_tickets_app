import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class Constants {
  static const Color primaryColor = Color(0xFFf03400);

  static const Color redColor = Color(0xFFed0000);

  static const Color orangeColor = Color(0xFFf04f00);

  static const Color starsColor = Color(0xFFf78040);

  static const Gradient buttonGradientRed = LinearGradient(
    colors: [primaryColor, redColor],
  );

  static const Gradient buttonGradientOrange = LinearGradient(
    colors: [orangeColor, redColor],
  );

  static const Gradient movieCarouselGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: [0.3, 0.6, 1],
    colors: [
      Color.fromRGBO(255, 255, 255, 0.95),
      Colors.white70,
      Colors.transparent,
    ],
  );

  static const Gradient blackOverlayGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.2, 0.5, 0.7, 1],
    colors: [
      Color.fromRGBO(0, 0, 0, 0.6),
      Color.fromRGBO(0, 0, 0, 0.45),
      Color.fromRGBO(0, 0, 0, 0.3),
      Colors.transparent,
    ],
  );

  static const Color buttonGreyColor = Color(0xFF1c1c1c);

  static const Color scaffoldColor = Color(0xFF141414);

  static const Color scaffoldGreyColor = Color(0xFF2b2b2b);

  static const Color textGreyColor = Color(0xFF949494);

  static const Color textWhite80Color = Color(0xFFf2f2f2);

  static const Color barrierColor = Colors.black87;

  static TextStyle latoFont = GoogleFonts.lato().copyWith(color: Colors.black);

  static TextStyle poppinsFont = GoogleFonts.poppins().copyWith(
    color: textWhite80Color,
  );

  static TextStyle robotoFont = GoogleFonts.roboto();

  static const Duration defaultAnimationDuration = Duration(milliseconds: 550);

  static const double bottomInsets = 65;

  static const double bottomInsetsLow = 45;

  static RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\.]+\.(com|pk)+",
  );

  static RegExp contactRegex = RegExp(r"^(03|3)\d{9}$");

  static RegExp fullNameRegex = RegExp(r"^[a-zA-Z ]+$");
}
