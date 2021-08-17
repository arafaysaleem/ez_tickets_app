import 'package:flutter_test/flutter_test.dart';

//Helpers
import 'package:ez_ticketz_app/helper/utils/constants.dart';
import 'package:ez_ticketz_app/helper/utils/form_validator.dart';

void main(){
  group('FormValidator',(){
    group('email input validations', (){
      test('non-empty valid email returns null', (){
        var result = FormValidator.emailValidator('test.email123@gmail.com');
        expect(result, null);
      });

      test('empty email returns error string', (){
        var result = FormValidator.emailValidator('');
        expect(result, Constants.emptyEmailInputError);
      });

      test('invalid email return error string', (){
        var result = FormValidator.emailValidator('email');
        expect(result, Constants.invalidEmailError);
      });
    });

    group("password inputs' validations", (){
      test('non-empty password returns null', (){
        var result = FormValidator.passwordValidator('pass');
        expect(result, null);
      });

      test('empty password returns error string', (){
        var result = FormValidator.passwordValidator('');
        expect(result, Constants.emptyPasswordInputError);
      });

      test('matching confirm password returns null', (){
        var result = FormValidator.confirmPasswordValidator('pass','pass');
        expect(result, null);
      });

      test('invalid confirm password returns error string', (){
        var result = FormValidator.confirmPasswordValidator('','pass');
        expect(result, Constants.invalidConfirmPwError);

        result = FormValidator.confirmPasswordValidator('pass','fail');
        expect(result, Constants.invalidConfirmPwError);
      });

      test('matching current password returns null', (){
        var result = FormValidator.currentPasswordValidator('pass','pass');
        expect(result, null);
      });

      test('invalid current password returns error string', (){
        var result = FormValidator.currentPasswordValidator('','pass');
        expect(result, Constants.invalidCurrentPwError);

        result = FormValidator.currentPasswordValidator('pass','fail');
        expect(result, Constants.invalidCurrentPwError);
      });

      test('non-empty valid new password returns null', (){
        var result = FormValidator.newPasswordValidator('oldPass','newPass');
        expect(result, null);
      });

      test('empty new password returns error string', (){
        var result = FormValidator.newPasswordValidator('','pass');
        expect(result, Constants.emptyPasswordInputError);
      });

      test('invalid new password returns error string', (){
        var result = FormValidator.newPasswordValidator('samePass','samePass');
        expect(result, Constants.invalidNewPwError);
      });
    });

    group("register user inputs' validations", (){
      test('a valid full name returns null', (){
        var result = FormValidator.fullNameValidator('full name');
        expect(result, null);
      });

      test('invalid full name returns error string', (){
        var result = FormValidator.fullNameValidator('');
        expect(result, Constants.invalidFullNameError);

        result = FormValidator.fullNameValidator('ful| n4m3');
        expect(result, Constants.invalidFullNameError);
      });

      test('non-empty address returns null', (){
        var result = FormValidator.addressValidator('123-A, Street Test');
        expect(result, null);
      });

      test('empty address returns error string', (){
        var result = FormValidator.addressValidator('');
        expect(result, Constants.emptyAddressInputError);
      });

      test('a valid contact returns null', (){
        var result = FormValidator.contactValidator('03001234567');
        expect(result, null);
      });

      test('invalid contact returns error string', (){
        var result = FormValidator.contactValidator('0300123');
        expect(result, Constants.invalidContactError);

        result = FormValidator.contactValidator('01001234567');
        expect(result, Constants.invalidContactError);

        result = FormValidator.contactValidator('abc123defg');
        expect(result, Constants.invalidContactError);
      });
    });

    group("payment inputs' validations", (){
      test('a valid zip code returns null', (){
        var result = FormValidator.zipCodeValidator('75400');
        expect(result, null);
      });

      test('invalid zip code returns error string', (){
        var result = FormValidator.zipCodeValidator('');
        expect(result, Constants.invalidZipCodeError);

        result = FormValidator.zipCodeValidator('800');
        expect(result, Constants.invalidZipCodeError);

        result = FormValidator.zipCodeValidator('abc');
        expect(result, Constants.invalidZipCodeError);

        result = FormValidator.zipCodeValidator('123456');
        expect(result, Constants.invalidZipCodeError);
      });

      test('valid promo code returns null', (){
        var result = FormValidator.promoCodeValidator('123456');
        expect(result, null);

        result = FormValidator.promoCodeValidator('abc123');
        expect(result, null);
      });

      test('invalid promo code returns error string', (){
        var result = FormValidator.promoCodeValidator('');
        expect(result, Constants.invalidPromoCodeError);

        result = FormValidator.promoCodeValidator('12345');
        expect(result, Constants.invalidPromoCodeError);
      });

      test('a non-empty branch name returns null', (){
        var result = FormValidator.branchNameValidator('Defence');
        expect(result, null);
      });

      test('empty branch name returns error string', (){
        var result = FormValidator.branchNameValidator('');
        expect(result, Constants.emptyBranchInputError);
      });

      test('a valid credit cart number returns null', (){
        var result = FormValidator.creditCardNumberValidator('5555555555550000');
        expect(result, null);

        result = FormValidator.creditCardNumberValidator('4555555555550000');
        expect(result, null);
      });

      test('invalid credit card number returns error string', (){
        var result = FormValidator.creditCardNumberValidator('');
        expect(result, Constants.invalidCreditCardNumberError);

        result = FormValidator.creditCardNumberValidator('asd');
        expect(result, Constants.invalidCreditCardNumberError);

        result = FormValidator.creditCardNumberValidator('5655555555550000');
        expect(result, Constants.invalidCreditCardNumberError);

        result = FormValidator.creditCardNumberValidator('455555555555');
        expect(result, Constants.invalidCreditCardNumberError);

        result = FormValidator.creditCardNumberValidator('1234567890000000');
        expect(result, Constants.invalidCreditCardNumberError);
      });

      test('a valid credit cart CVV returns null', (){
        var result = FormValidator.creditCardCVVValidator('178');
        expect(result, null);
      });

      test('invalid credit card CVV returns error string', (){
        var result = FormValidator.creditCardCVVValidator('');
        expect(result, Constants.invalidCreditCardCVVError);

        result = FormValidator.creditCardCVVValidator('1');
        expect(result, Constants.invalidCreditCardCVVError);

        result = FormValidator.creditCardCVVValidator('1234');
        expect(result, Constants.invalidCreditCardCVVError);

        result = FormValidator.creditCardCVVValidator('asd');
        expect(result, Constants.invalidCreditCardCVVError);
      });

      test('a valid credit cart expiry returns null', (){
        var result = FormValidator.creditCardExpiryValidator('09/2021');
        expect(result, null);

        result = FormValidator.creditCardExpiryValidator('12/2030');
        expect(result, null);
      });

      test('invalid credit card expiry returns error string', (){
        var result = FormValidator.creditCardExpiryValidator('');
        expect(result, Constants.invalidCreditCardExpiryError);

        result = FormValidator.creditCardExpiryValidator('123');
        expect(result, Constants.invalidCreditCardExpiryError);

        result = FormValidator.creditCardExpiryValidator('asd');
        expect(result, Constants.invalidCreditCardExpiryError);

        result = FormValidator.creditCardExpiryValidator('09-2021');
        expect(result, Constants.invalidCreditCardExpiryError);

        result = FormValidator.creditCardExpiryValidator('09/1900');
        expect(result, Constants.invalidCreditCardExpiryError);

        result = FormValidator.creditCardExpiryValidator('00/2021');
        expect(result, Constants.invalidCreditCardExpiryError);

        result = FormValidator.creditCardExpiryValidator('13/2021');
        expect(result, Constants.invalidCreditCardExpiryError);
      });
    });

    group("otp inputs' validations",(){
      test('a valid otp digit returns null', (){
        final result = FormValidator.otpDigitValidator('3');
        expect(result, null);
      });

      test('invalid otp digit returns error string', (){
        final result = FormValidator.otpDigitValidator('ab3');
        expect(result, '!');
      });
    });
  });
}
