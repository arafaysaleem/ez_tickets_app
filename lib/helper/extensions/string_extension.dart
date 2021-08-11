// ignore_for_file: unnecessary_this
import '../utils/constants.dart';

/// A utility with extensions for strings.
extension StringExt on String {
  /// An extension for validating String is an email.
  bool get isValidEmail => Constants.emailRegex.hasMatch(this);

  /// An extension for validating String is a full name.
  bool get isValidFullName => Constants.fullNameRegex.hasMatch(this);

  /// An extension for validating String is a contact.
  bool get isValidContact => Constants.contactRegex.hasMatch(this);

  /// An extension for validating String is a zipcode.
  bool get isValidZipCode => Constants.zipCodeRegex.hasMatch(this);

  /// An extension for validating String is a credit card number.
  bool get isValidCreditCardNumber => Constants.creditCardNumberRegex.hasMatch(this);

  /// An extension for validating String is a credit card CVV.
  bool get isValidCreditCardCVV => Constants.creditCardCVVRegex.hasMatch(this);

  /// An extension for validating String is a credit card expiry.
  bool get isValidCreditCardExpiry => Constants.creditCardExpiryRegex.hasMatch(this);
  
  /// An extension for validating String is a valid OTP digit
  bool get isValidOtpDigit => Constants.otpDigitRegex.hasMatch(this);

  /// An extension for converting String to Capitalcase.
  String get capitalize => this[0].toUpperCase() + this.substring(1).toLowerCase();

  /// An extension for replacing underscores in a String with spaces.
  String get removeUnderScore => this.replaceAll('_', ' ');
}
