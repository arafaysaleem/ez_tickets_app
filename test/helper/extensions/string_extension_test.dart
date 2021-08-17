import 'package:flutter_test/flutter_test.dart';
import 'package:ez_ticketz_app/helper/extensions/string_extension.dart';

void main() {
  group('StringExt', () {
    group('isValidEmail', () {
      test(
        'GIVEN a valid email '
        'WHEN extension method `.isValidEmail is called '
        'THEN true is returned',
        () {
          //given
          const email = 'test.user@domain.com';

          //when
          final isValid = email.isValidEmail;

          //then
          expect(isValid, true);
        },
      );
      test(
        'GIVEN an invalid email '
        'WHEN extension method `.isValidEmail is called '
        'THEN false is returned',
        () {
          //given
          var email = 'test@user@domain.com';

          //when
          var isValid = email.isValidEmail;

          //then
          expect(isValid, false);

          //given
          email = 'user@domain';

          //when
          isValid = email.isValidEmail;

          //then
          expect(isValid, false);
        },
      );
    });

    group('isValidFullName', () {
      test(
        'GIVEN a valid full name '
        'WHEN extension method `.isValidFullName is called '
        'THEN true is returned',
        () {
          //given
          const fullName = 'Test User';

          //when
          final isValid = fullName.isValidFullName;

          //then
          expect(isValid, true);
        },
      );
      test(
        'GIVEN an invalid full name '
        'WHEN extension method `.isValidFullName is called '
        'THEN false is returned',
        () {
          //given
          var fullName = 'Test2User';

          //when
          var isValid = fullName.isValidFullName;

          //then
          expect(isValid, false);

          //given
          fullName = 'Test @- User';

          //when
          isValid = fullName.isValidFullName;

          //then
          expect(isValid, false);
        },
      );
    });

    group('isValidContact', () {
      test(
        'GIVEN a valid contact '
        'WHEN extension method `.isValidContact is called '
        'THEN true is returned',
        () {
          //given
          var contact = '03001234567';

          //when
          var isValid = contact.isValidContact;

          //then
          expect(isValid, true);

          //given
          contact = '3001234567';

          //when
          isValid = contact.isValidContact;

          //then
          expect(isValid, true);
        },
      );

      test(
        'GIVEN an invalid contact '
        'WHEN extension method `.isValidContact is called '
        'THEN false is returned',
        () {
          //given
          var contact = '1234';

          //when
          var isValid = contact.isValidContact;

          //then
          expect(isValid, false);

          //given
          contact = '02001234567';

          //when
          isValid = contact.isValidContact;

          //then
          expect(isValid, false);

          //given
          contact = 'abc';

          //when
          isValid = contact.isValidContact;

          //then
          expect(isValid, false);
        },
      );
    });

    group('isValidZipCode', () {
      test(
        'GIVEN a valid zip code '
        'WHEN extension method `.isValidZipCode is called '
        'THEN true is returned',
        () {
          //given
          const zipCode = '75400';

          //when
          final isValid = zipCode.isValidZipCode;

          //then
          expect(isValid, true);
        },
      );

      test(
        'GIVEN an invalid zip code '
        'WHEN extension method `.isValidZipCode is called '
        'THEN false is returned',
        () {
          //given
          var zipCode = '123';

          //when
          var isValid = zipCode.isValidZipCode;

          //then
          expect(isValid, false);

          //given
          zipCode = 'abc';

          //when
          isValid = zipCode.isValidZipCode;

          //then
          expect(isValid, false);
        },
      );
    });

    group('isValidCreditCardNumber', () {
      test(
        'GIVEN a valid credit card number '
        'WHEN extension method `.isValidCreditCardNumber is called '
        'THEN true is returned',
        () {
          //given
          var creditCardNumber = '5555555555550000';

          //when
          var isValid = creditCardNumber.isValidCreditCardNumber;

          //then
          expect(isValid, true);

          //given
          creditCardNumber = '4555555555550000';

          //when
          isValid = creditCardNumber.isValidCreditCardNumber;

          //then
          expect(isValid, true);
        },
      );

      test(
        'GIVEN an invalid credit card number '
        'WHEN extension method `.isValidCreditCardNumber is called '
        'THEN false is returned',
        () {
          //given
          var creditCardNumber = '1234567890000000';

          //when
          var isValid = creditCardNumber.isValidCreditCardNumber;

          //then
          expect(isValid, false);

          //given
          creditCardNumber = 'asd';

          //when
          isValid = creditCardNumber.isValidCreditCardNumber;

          //then
          expect(isValid, false);
        },
      );
    });

    group('isValidCreditCardCVV', () {
      test(
        'GIVEN a valid credit card cvv '
        'WHEN extension method `.isValidCreditCardCVV is called '
        'THEN true is returned',
        () {
          //given
          var creditCardCVV = '178';

          //when
          var isValid = creditCardCVV.isValidCreditCardCVV;

          //then
          expect(isValid, true);
        },
      );
      test(
        'GIVEN an invalid credit card cvv '
        'WHEN extension method `.isValidCreditCardCVV is called '
        'THEN false is returned',
        () {
          //given
          var creditCardCVV = '1';

          //when
          var isValid = creditCardCVV.isValidCreditCardCVV;

          //then
          expect(isValid, false);

          //given
          creditCardCVV = 'asd';

          //when
          isValid = creditCardCVV.isValidCreditCardCVV;

          //then
          expect(isValid, false);
        },
      );
    });

    group('isValidCreditCardExpiry', () {
      test(
        'GIVEN a valid credit card expiry '
        'WHEN extension method `.isValidCreditCardExpiry is called '
        'THEN true is returned',
        () {
          //given
          const creditCardExpiry = '09/2021';

          //when
          final isValid = creditCardExpiry.isValidCreditCardExpiry;

          //then
          expect(isValid, true);
        },
      );
      test(
        'GIVEN an invalid credit card expiry '
        'WHEN extension method `.isValidCreditCardExpiry is called '
        'THEN false is returned',
        () {
          //given
          var creditCardExpiry = '123';

          //when
          var isValid = creditCardExpiry.isValidCreditCardExpiry;

          //then
          expect(isValid, false);

          //given
          creditCardExpiry = '09-2021';

          //when
          isValid = creditCardExpiry.isValidCreditCardExpiry;

          //then
          expect(isValid, false);

          //given
          creditCardExpiry = '00/1900';

          //when
          isValid = creditCardExpiry.isValidCreditCardExpiry;

          //then
          expect(isValid, false);
        },
      );
    });

    group('isValidOtpDigit', () {
      test(
        'GIVEN a valid otp code '
        'WHEN extension method `.isValidOtpDigit is called '
        'THEN true is returned',
        () {
          //given
          const otpDigit = '4';

          //when
          final isValid = otpDigit.isValidOtpDigit;

          //then
          expect(isValid, true);
        },
      );

      test(
        'GIVEN an invalid otp digit '
        'WHEN extension method `.isValidOtpDigit is called '
        'THEN false is returned',
        () {
          //given
          var otpDigit = '14';

          //when
          var isValid = otpDigit.isValidOtpDigit;

          //then
          expect(isValid, false);

          //given
          otpDigit = '#';

          //when
          isValid = otpDigit.isValidOtpDigit;

          //then
          expect(isValid, false);

          //given
          otpDigit = 'abc';

          //when
          isValid = otpDigit.isValidOtpDigit;

          //then
          expect(isValid, false);
        },
      );
    });
  });
}
