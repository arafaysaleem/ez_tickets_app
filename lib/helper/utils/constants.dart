import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  static Color get primaryColor => Color(0xFFf02c00);

  static Color get secondaryColor => Color(0xFFed1d04);

  static Color get tertiaryColor => Color(0xFFf76540);

  static Color get buttonGreyColor => Color(0xFF1c1c1c);

  static Color get scaffoldColor => Color(0xFF141414);

  static Color get scaffoldGreyColor => Color(0xFF2b2b2b);

  static Color get textGreyColor => Color(0xFF949494);

  static TextStyle get latoFont =>
      GoogleFonts.lato().copyWith(color: Colors.black);

  static TextStyle get poppinsFont =>
      GoogleFonts.poppins().copyWith(color: Colors.white);
}
