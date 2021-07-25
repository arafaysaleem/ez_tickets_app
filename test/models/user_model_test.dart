import 'package:ez_ticketz_app/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

//Enums
import 'package:ez_ticketz_app/enums/user_role_enum.dart';

void main() {
  group("fromJson", () {
    test(
      "GIVEN a json serialization is needed"
      "WHEN a valid user json is input"
      "THEN a user model is output",
      () {
        //given
        final json = {
          "user_id": 1,
          "full_name": "Test User",
          "email": "test.email@gmail.com",
          "address": "ABC-1/BLOCK TEST",
          "contact": "03001234567",
          "role": UserRole.API_USER.toJson, //evaluates to api_user
        };

        //when
        final actual = UserModel.fromJson(json);
        const matcher = UserModel(
          userId: 1,
          fullName: "Test User",
          email: "test.email@gmail.com",
          address: "ABC-1/BLOCK TEST",
          contact: "03001234567",
          role: UserRole.API_USER,
        );

        //then
        expect(actual, matcher);
      },
    );
  });

  group("toJson", () {
    test(
      "GIVEN a json deserialization is needed"
      "WHEN a user model with user id is converted"
      "THEN a user json with user id is output",
      () {
        //given
        const user = UserModel(
          userId: 1,
          fullName: "Test User",
          email: "test.email@gmail.com",
          address: "ABC-1/BLOCK TEST",
          contact: "03001234567",
          role: UserRole.API_USER,
        );

        //when
        final actual = user.toJson();
        final matcher = {
          "user_id": 1,
          "full_name": "Test User",
          "email": "test.email@gmail.com",
          "address": "ABC-1/BLOCK TEST",
          "contact": "03001234567",
          "role": UserRole.API_USER.toJson, //evaluates to api_user
        };

        //then
        expect(actual, matcher);
      },
    );

    test(
      "GIVEN a json deserialization is needed"
      "WHEN a user model with null user id is converted"
      "THEN a user json without user id is output",
      () {
        //given
        const user = UserModel(
          userId: null,
          fullName: "Test User",
          email: "test.email@gmail.com",
          address: "ABC-1/BLOCK TEST",
          contact: "03001234567",
          role: UserRole.API_USER,
        );

        //when
        final actual = user.toJson();
        final matcher = {
          "full_name": "Test User",
          "email": "test.email@gmail.com",
          "address": "ABC-1/BLOCK TEST",
          "contact": "03001234567",
          "role": UserRole.API_USER.toJson, //evaluates to api_user
        };

        //then
        expect(actual, matcher);
      },
    );
  });

  group("equality", () {
    test(
      "GIVEN two user models"
      "WHEN properties are different"
      "THEN equality returns false",
      () {
        const job1 = UserModel(
          userId: 1,
          fullName: "Test User",
          email: "test.email@gmail.com",
          address: "ABC-1/BLOCK TEST",
          contact: "03001234567",
          role: UserRole.API_USER,
        );
        const job2 = UserModel(
          userId: 1,
          fullName: "Test User 2",
          email: "test.email@gmail.com",
          address: "ABC-1/BLOCK TEST",
          contact: "03001234567",
          role: UserRole.API_USER,
        );
        expect(job1 == job2, false);
      },
    );

    test(
      "GIVEN two user models"
      "WHEN properties are same"
      "THEN equality returns true",
      () {
        const job1 = UserModel(
          userId: 1,
          fullName: "Test User",
          email: "test.email@gmail.com",
          address: "ABC-1/BLOCK TEST",
          contact: "03001234567",
          role: UserRole.API_USER,
        );
        const job2 = UserModel(
          userId: 1,
          fullName: "Test User",
          email: "test.email@gmail.com",
          address: "ABC-1/BLOCK TEST",
          contact: "03001234567",
          role: UserRole.API_USER,
        );
        expect(job1 == job2, true);
      },
    );
  });
}
