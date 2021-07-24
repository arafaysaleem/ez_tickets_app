import 'package:flutter_test/flutter_test.dart';

//Helpers
import 'package:ez_ticketz_app/helper/utils/constants.dart';
import 'package:ez_ticketz_app/helper/utils/form_validator.dart';

void main(){
  group("email input validations", (){
    test("non-empty valid email returns null", (){
      var result = FormValidator.emailValidator("test.email123@gmail.com");
      expect(result, null);
    });

    test("empty email return error string", (){
      var result = FormValidator.emailValidator("");
      expect(result, Constants.emptyEmailInputError);
    });

    test("invalid email return error string", (){
      var result = FormValidator.emailValidator("email");
      expect(result, Constants.invalidEmailError);
    });
  });

  group("password input validations", (){
    test("non-empty password returns null", (){
      var result = FormValidator.passwordValidator("pass");
      expect(result, null);
    });

    test("empty password return error string", (){
      var result = FormValidator.passwordValidator("");
      expect(result, Constants.emptyPasswordInputError);
    });

    test("invalid confirm password return error string", (){
      var result = FormValidator.confirmPasswordValidator("pass","fail");
      expect(result, Constants.invalidConfirmPwError);
    });

    test("invalid current password return error string", (){
      var result = FormValidator.currentPasswordValidator("pass","fail");
      expect(result, Constants.invalidCurrentPwError);
    });

    test("invalid new password return error string", (){
      var result = FormValidator.newPasswordValidator("samePass","samePass");
      expect(result, Constants.invalidNewPwError);
    });
  });
}
