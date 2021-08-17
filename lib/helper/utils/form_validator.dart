import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//Helpers
import '../../helper/extensions/string_extension.dart';
import 'constants.dart';

/// A utility class that holds methods for validating different textFields.
/// This class has no constructor and all methods are `static`.
@immutable
class FormValidator{
  const FormValidator._();

  /// A method containing validation logic for email input.
  static String? emailValidator(String? email){
    if(email == null || email.isEmpty) {
      return Constants.emptyEmailInputError;
    } else if (!email.isValidEmail) {
      return Constants.invalidEmailError;
    }
    return null;
  }

  /// A method containing validation logic for password input.
  static String? passwordValidator(String? password) {
    if (password!.isEmpty) return Constants.emptyPasswordInputError;
    return null;
  }

  /// A method containing validation logic for confirm password input.
  static String? confirmPasswordValidator(String? confirmPw, String inputPw) {
    if (confirmPw == inputPw.trim()) return null;
    return Constants.invalidConfirmPwError;
  }

  /// A method containing validation logic for current password input.
  static String? currentPasswordValidator(String? inputPw, String currentPw) {
    if (inputPw == currentPw) return null;
    return Constants.invalidCurrentPwError;
  }

  /// A method containing validation logic for new password input.
  static String? newPasswordValidator(String? newPw, String currentPw) {
    if (newPw!.isEmpty) {
      return Constants.emptyPasswordInputError;
    }
    else if(newPw == currentPw) {
      return Constants.invalidNewPwError;
    }
    return null;
  }

  /// A method containing validation logic for full name input.
  static String? fullNameValidator(String? fullName) {
    if (fullName != null && fullName.isValidFullName) return null;
    return Constants.invalidFullNameError;
  }

  /// A method containing validation logic for address input.
  static String? addressValidator(String? address) {
    if (address!.isEmpty) return Constants.emptyAddressInputError;
    return null;
  }

  /// A method containing validation logic for contact number input.
  static String? contactValidator(String? contact) {
    if (contact != null && contact.isValidContact) return null;
    return Constants.invalidContactError;
  }

  /// A method containing validation logic for zipcode input.
  static String? zipCodeValidator(String? zipCode) {
    if (zipCode != null && zipCode.isValidZipCode) return null;
    return Constants.invalidZipCodeError;
  }

  /// A method containing validation logic for promo code input.
  static String? promoCodeValidator(String? promoCode) {
    if (promoCode != null && promoCode.length == 6) return null;
    return Constants.invalidPromoCodeError;
  }

  /// A method containing validation logic for cinema branch name input.
  static String? branchNameValidator(String? branchName) {
    if (branchName!.isEmpty) return Constants.emptyBranchInputError;
    return null;
  }

  /// A method containing validation logic for credit card number input.
  static String? creditCardNumberValidator(String? ccNumber) {
    if (ccNumber != null && ccNumber.isValidCreditCardNumber) return null;
    return Constants.invalidCreditCardNumberError;
  }

  /// A method containing validation logic for credit card CVV input.
  static String? creditCardCVVValidator(String? cvv) {
    if (cvv != null && cvv.isValidCreditCardCVV) return null;
    return Constants.invalidCreditCardCVVError;
  }

  /// A method containing validation logic for credit card expiry input.
  static String? creditCardExpiryValidator(String? expiry) {
    if (expiry != null && expiry.isValidCreditCardExpiry) return null;
    return Constants.invalidCreditCardExpiryError;
  }

  /// A method containing validation logic for single otp digit input.
  static String? otpDigitValidator(String? digit){
    if (digit != null && digit.isValidOtpDigit) return null;
    return '!';
  }

}
