import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A utility class that holds constants for useful and commonly
/// used values throughout the entire app.
/// This class has no constructor and all variables are `static`.
@immutable
class Constants {
  const Constants._();

  /// The main orange-red color used for theming the app.
  static const Color primaryColor = Color(0xFFf03400);

  /// The color value for red color in the app.
  static const Color redColor = Color(0xFFed0000);

  /// The color value for orange color in the app.
  static const Color orangeColor = Color(0xFFf04f00);

  /// The color value for rating stars in the app.
  static const Color starsColor = Color(0xFFf78040);

  /// The color value for dark grey skeleton containers in the app.
  static const Color darkSkeletonColor = Color(0xFF656565);

  /// The color value for light grey skeleton containers in the app.
  static const Color lightSkeletonColor = Colors.grey;

  /// The red [LinearGradient] for buttons in the app.
  static const Gradient buttonGradientRed = LinearGradient(
    colors: [primaryColor, redColor],
  );

  /// The orange [LinearGradient] for buttons in the app.
  static const Gradient buttonGradientOrange = LinearGradient(
    colors: [orangeColor, redColor],
  );

  /// The orange [LinearGradient] for disabled buttons in the app.
  static const Gradient buttonGradientGrey = LinearGradient(
    colors: [textGreyColor, scaffoldGreyColor],
  );

  /// The price for a single seat ticket
  static const double ticketPrice = 800;

  /// The white [LinearGradient] for fading movies carousel in the app.
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

  /// The black [LinearGradient] used to overlay movie backgrounds in the app.
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

  /// The color value for dark grey buttons in the app.
  static const Color buttonGreyColor = Color(0xFF1c1c1c);

  /// The color value for dark grey scaffold in the app.
  static const Color scaffoldColor = Color(0xFF141414);

  /// The color value for light grey scaffold in the app.
  static const Color scaffoldGreyColor = Color(0xFF2b2b2b);

  /// The color value for light grey text in the app.
  static const Color textGreyColor = Color(0xFF949494);

  /// The color value for white text in the app.
  static const Color textWhite80Color = Color(0xFFf2f2f2);

  /// The color value for dark grey [CustomDialog] in the app.
  static const Color barrierColor = Colors.black87;

  /// The color value for light grey [CustomDialog] in the app.
  static const Color barrierColorLight = Color(0xBF000000);

  /// The TextStyle for Lato font in the app.
  static TextStyle latoFont = GoogleFonts.lato().copyWith(color: Colors.black);

  /// The TextStyle for Poppins font in the app.
  static TextStyle poppinsFont = GoogleFonts.poppins().copyWith(
    color: textWhite80Color,
  );

  /// The TextStyle for Roboto font in the app.
  static TextStyle robotoFont = GoogleFonts.roboto();

  /// The default [Duration] value for animations in the app.
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);

  /// The value for bottom padding of buttons in the app.
  /// It is measured from the bottom of the screen, that is
  /// behind the android system navigation.
  /// Used to prevent overlapping of android navigation with the button.
  static const double bottomInsets = 65;

  /// The value for a smaller bottom padding of buttons in the app.
  /// It is measured from the bottom of the screen, that is
  /// behind the android system navigation.
  /// Used to prevent overlapping of android navigation with the button.
  static const double bottomInsetsLow = 48;

  /// The max number of rows a theater can contain
  static const int maxSeatRows = 12;

  /// The regular expression for validating emails in the app.
  static RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\.]+\.(com|pk)+",
  );

  /// The regular expression for validating contacts in the app.
  static RegExp contactRegex = RegExp(r'^(03|3)\d{9}$');

  /// The regular expression for validating full names in the app.
  static RegExp fullNameRegex = RegExp(r'^[a-zA-Z ]+$');

  /// The regular expression for validating zip codes in the app.
  static RegExp zipCodeRegex = RegExp(r'^\d{5}$');

  /// The regular expression for validating credit card numbers in the app.
  static RegExp creditCardNumberRegex = RegExp(r'^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14})$');

  /// The regular expression for validating credit card CVV in the app.
  static RegExp creditCardCVVRegex = RegExp(r'^[0-9]{3}$');

  /// The regular expression for validating credit card expiry in the app.
  static RegExp creditCardExpiryRegex = RegExp(r'(0[1-9]|10|11|12)/20[0-9]{2}$');

  /// The regular expression for validating credit card expiry in the app.
  static final RegExp otpDigitRegex = RegExp('^[0-9]{1}\$');

  /// The error message for invalid email input.
  static const invalidEmailError = 'Please enter a valid email address';

  /// The error message for empty email input.
  static const emptyEmailInputError = 'Please enter an email';

  /// The error message for empty password input.
  static const emptyPasswordInputError = 'Please enter a password';

  /// The error message for invalid confirm password input.
  static const invalidConfirmPwError = "Passwords don't match";

  /// The error message for invalid current password input.
  static const invalidCurrentPwError = 'Invalid current password!';

  /// The error message for invalid new password input.
  static const invalidNewPwError = "Current and new password can't be same";

  /// The error message for invalid full name input.
  static const invalidFullNameError = 'Please enter a valid full name';

  /// The error message for empty address input.
  static const emptyAddressInputError = 'Please enter a address';

  /// The error message for empty cinema branch input.
  static const emptyBranchInputError = 'Please enter the branch name';

  /// The error message for invalid contact input.
  static const invalidContactError = 'Please enter a valid contact';

  /// The error message for invalid zip code input.
  static const invalidZipCodeError = 'Please enter a valid zip code';

  /// The error message for invalid promo code input.
  static const invalidPromoCodeError = 'Please enter a valid promo code';

  /// The error message for invalid credit card number input.
  static const invalidCreditCardNumberError = 'Invalid credit card number';

  /// The error message for invalid credit card CVV input.
  static const invalidCreditCardCVVError = 'Please enter a valid CVV';

  /// The error message for invalid credit card expiry input.
  static const invalidCreditCardExpiryError = 'Please enter a valid expiry date';

  static T? toNull<T>(Object? _) => null;
}
